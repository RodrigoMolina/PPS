class Message < ApplicationRecord
  
  include Destroyable

  #--------------------------------------------- RELATION
  belongs_to :source_profile, class_name: 'Profile'
  belongs_to :destination_profile, class_name: 'Profile'

  #--------------------------------------------- MISC

  #--------------------------------------------- VALIDATION
  validates :source_profile_id, :destination_profile_id, :body, presence: true

  #--------------------------------------------- CALLBACK

  #--------------------------------------------- SCOPES

  #--------------------------------------------- METHODS
  
end



