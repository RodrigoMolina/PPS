class WorkshopScheduleMessageObserver < ApplicationRecord
  
  include Destroyable

  #--------------------------------------------- RELATION
  belongs_to :workshop_schedule_message
  has_one :workshop_schedule, through: :workshop_schedule_message
  has_one :workshop, through: :workshop_schedule
  belongs_to :profile

  #--------------------------------------------- MISC

  #--------------------------------------------- VALIDATION

  #--------------------------------------------- CALLBACK

  #--------------------------------------------- SCOPES
  scope :state_new, -> { where(state: :new) }
  scope :kind_learner, -> { where(kind: :learner) }
  scope :kind_teacher, -> { where(kind: :teacher) }

  #--------------------------------------------- METHODS
  
  
end



