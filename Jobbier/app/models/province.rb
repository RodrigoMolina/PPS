class Province < ApplicationRecord

  include Destroyable

  #--------------------------------------------- RELATION
  has_many :workshops
  has_many :profiles
  has_many :cities
  belongs_to :country


  #--------------------------------------------- MISC

  #--------------------------------------------- VALIDATION

  #--------------------------------------------- CALLBACK

  #--------------------------------------------- SCOPES
  scope :order_default, -> { order('name ASC') }

  #--------------------------------------------- METHODS

  def destroyable?
    workshops.empty? && profiles.empty? && cities.empty?
  end


  def to_s
    name
  end

end
