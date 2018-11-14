class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable ,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  include Destroyable

  #--------------------------------------------- RELATION
  #has_and_belongs_to_many :oauth_credentials
  has_one :profile
  has_one :admin_profile
  has_one :normal_profile

  has_many :identities, dependent: :destroy
  #has_many :showroom_visits, dependent: :destroy

  #--------------------------------------------- MISC
  accepts_nested_attributes_for :admin_profile
  accepts_nested_attributes_for :normal_profile
  delegate :to_s, :name, to: :profile

  #--------------------------------------------- VALIDATION

  #--------------------------------------------- CALLBACK

  #--------------------------------------------- SCOPES

  #--------------------------------------------- METHODS

  def source_facebook?
    omniauth_access? && identities.collect{|i| i.provider}.include?('facebook')
  end

  def source_google?
    omniauth_access? && identities.collect{|i| i.provider}.include?('google_oauth2')
  end

  def omniauth_access?
    identities.any?
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    # unless user
    #     user = User.create(name: data['name'],
    #        email: data['email'],
    #        password: Devise.friendly_token[0,20]
    #     )
    # end
    user
end



  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)
    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?
      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      user = User.where(email: auth.info.email).take

      # Create the user if it's a new registration
      if user.nil?

        require 'net/http'
        require 'json'

        if (identity.provider == 'facebook')
          url = "#{auth.info.image}?redirect=false&type=large"
          uri = URI(url)
          response = Net::HTTP.get(uri)
          response_parsed = JSON.parse(response)
          image = auth.extra.raw_info.picture.data.url
        end


        normal_profile = NormalProfile.new(name: auth.info.first_name, surname: auth.info.last_name, image: Image.new(remote_file_url: image))
        case auth.extra.raw_info.gender
        when 'male'
          normal_profile.gender = :male
        when 'female'
          normal_profile.gender = :female
        end

        normal_profile.birthdate = Date.strptime(auth.extra.raw_info.birthday, '%m/%d/%Y').to_s if auth.extra.raw_info.birthday.present?

        user = User.new(
          normal_profile: normal_profile,
          email: auth.info.email,
          password: Devise.friendly_token[0,20]
          )

        user.skip_confirmation!
        user.save
      end

    end

    # Associate the identity with the user if needed
    #if (user.visitor_profile.present?) && (identity.user != user)
    if (identity.user != user)
      identity.user = user
      identity.save!
    end
    user
  end




  def user_never_login?
    0 == sign_in_count
  end

   def update_without_password(params, *options)

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

end
