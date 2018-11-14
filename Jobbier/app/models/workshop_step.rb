class WorkshopStep < ApplicationRecord
  
  include Destroyable

  #--------------------------------------------- RELATION
  belongs_to :workshop

  #--------------------------------------------- MISC

  #--------------------------------------------- VALIDATION
  validates :step, presence: true

  #--------------------------------------------- CALLBACK

  #--------------------------------------------- SCOPES
  scope :filter_step, ->(q) { where('workshop_steps.step = ?', q) }
  scope :filter_steps, ->(q) { where('workshop_steps.step IN (?)', q) }

  #--------------------------------------------- METHODS
  
  def ok_true
  	update_column(:ok, true)
  end

  def ok_false
  	update_column(:ok, false)
  end

end



