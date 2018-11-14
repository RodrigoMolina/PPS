class NormalProfile < Profile


  #--------------------------------------------- RELATION
  has_many :workshops
  has_many :workshop_schedule_subscribeds
  has_many :workshop_schedules, through: :workshop_schedule_subscribeds, source: :workshop_schedule
  has_many :subscribed_workshops, through: :workshop_schedules, source: :workshop


  has_many :notifications, dependent: :destroy

  has_many :workshop_favorites, dependent: :destroy
  has_many :favorite_workshops, through: :workshop_favorites, source: :workshop

  has_many :to_teaches, dependent: :destroy
  has_many :to_learns, dependent: :destroy

  has_many :workshop_category_to_teaches, through: :to_teaches, source: :workshop_category
  has_many :workshop_category_to_learns, through: :to_learns, source: :workshop_category

  

  #--------------------------------------------- MISC

  #--------------------------------------------- VALIDATION
  validates :name, :surname, presence: true

  #--------------------------------------------- CALLBACK

  #--------------------------------------------- SCOPES

  #--------------------------------------------- METHODS
  def kind
    'normal'
  end

  def send_email_access_login
    CustomMailer::workshop_created(self)
  end

  def destroyable?
    workshops.empty? && workshop_subscribeds.empty?
  end


  PREFERENCE_PLACE_TYPES = [:out_door, :in_door, :other]
  PREFERENCE_ASSISTANCE_TYPES = [:single, :group, :twice]
  PREFERENCE_TIME_TYPES = [:day, :night, :always]


end
