class Profile < ApplicationRecord

  include Destroyable

  #--------------------------------------------- RELATION
  belongs_to :user, dependent: :destroy
  belongs_to :image, dependent: :destroy
  belongs_to :country
  belongs_to :province
  belongs_to :city
  has_many :source_message, dependent: :destroy
  has_many :destination_message, dependent: :destroy

  has_many :workshop_schedule_messages, dependent: :destroy

  has_many :workshop_schedule_message_observers

  #--------------------------------------------- MISC
  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :image, allow_destroy: true, reject_if: proc { |attributes| attributes['file_cache'].blank? && attributes['file'].blank? && attributes['id'].blank? }
  delegate :email, :user_never_login?, to: :user


  #--------------------------------------------- VALIDATION

  #--------------------------------------------- CALLBACK

  #--------------------------------------------- SCOPES

  #--------------------------------------------- METHODS

  def type_admin?
    (kind == 'admin')
  end

  def type_normal?
    (kind == 'normal')
  end

  def to_s
    (surname.present?)? "#{surname} #{name}" : name
  end

  def get_image
    ((image.nil?) || (image.file.nil?))? 'avatar_default.png' : image.file_with_relative_path
  end

  def get_image_thumb
    ((image.nil?) || (image.file.nil?))? 'avatar_default.png' : image.file_thumb_with_relative_path
  end

end
