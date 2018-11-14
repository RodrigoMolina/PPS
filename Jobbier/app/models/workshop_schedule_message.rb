class WorkshopScheduleMessage < ApplicationRecord
  
  include Destroyable

  #--------------------------------------------- RELATION
  belongs_to :workshop_schedule
  belongs_to :profile
  has_many :workshop_schedule_message_observers, dependent: :destroy

  #--------------------------------------------- MISC

  #--------------------------------------------- VALIDATION
  validates :profile_id, :body, presence: true

  #--------------------------------------------- CALLBACK
  after_create :generate_observers

  #--------------------------------------------- SCOPES

  #--------------------------------------------- METHODS
  def generate_observers
    teacher = workshop_schedule.workshop.normal_profile

    workshop_schedule.subscribed_normal_profiles.each do |p|
      if profile != p
        workshop_schedule_message_observers << WorkshopScheduleMessageObserver.new(workshop_schedule_message: self, profile: p, kind: 'learner')
      end
    end
    
    if profile != teacher
      workshop_schedule_message_observers << WorkshopScheduleMessageObserver.new(workshop_schedule_message: self, profile: teacher, kind: 'teacher')
    end
  end
  
end



