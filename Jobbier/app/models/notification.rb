class Notification < ApplicationRecord
  
  include Destroyable

  #--------------------------------------------- RELATION
  belongs_to :normal_profile

  #--------------------------------------------- MISC

  #--------------------------------------------- VALIDATION

  #--------------------------------------------- CALLBACK

  #--------------------------------------------- SCOPES
  scope :filter_new, -> { where(state: 'new') }
  scope :filter_viewed, -> { where(state: 'viewed') }

  #--------------------------------------------- METHODS
  
end



