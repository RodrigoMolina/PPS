class Country < ApplicationRecord

  include Destroyable

  #--------------------------------------------- RELATION
  has_many :workshops
  has_many :profiles
  has_many :provinces

  #--------------------------------------------- MISC

  #--------------------------------------------- VALIDATION

  #--------------------------------------------- CALLBACK

  #--------------------------------------------- SCOPES
  scope :order_default, -> { order('name ASC') }

  #--------------------------------------------- METHODS

  def destroyable?
    workshops.empty? && profiles.empty? &&provinces.empty?
  end

  def to_s
    name
  end

end
