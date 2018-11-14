class City < ApplicationRecord

  include Destroyable

  #--------------------------------------------- RELATION
  has_many :profiles
  has_many :workshops
  belongs_to :province

  #--------------------------------------------- MISC

  #--------------------------------------------- VALIDATION

  #--------------------------------------------- CALLBACK

  #--------------------------------------------- SCOPES
  scope :order_default, -> { order('name ASC') }

  #--------------------------------------------- METHODS

  def destroyable?
    workshops.empty? && profiles.empty?
  end

  def to_s
    name
  end

end
