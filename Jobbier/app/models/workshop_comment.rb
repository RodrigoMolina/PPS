class WorkshopComment < ApplicationRecord
  
  include Destroyable

  #--------------------------------------------- RELATION
  belongs_to :workshop
  belongs_to :normal_profile

  #--------------------------------------------- MISC

  #--------------------------------------------- VALIDATION
  validates :normal_profile_id, :score, :comment, presence: true

  #--------------------------------------------- CALLBACK
  

  #--------------------------------------------- SCOPES

  #--------------------------------------------- METHODS
  
end



