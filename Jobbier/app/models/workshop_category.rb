class WorkshopCategory < ApplicationRecord

  include Destroyable

  #--------------------------------------------- RELATION

  has_many :workshops

  belongs_to :image_cover, class_name: 'Image', dependent: :destroy
  belongs_to :image_card_category, class_name: 'Image', dependent: :destroy

  has_many :to_teaches
  has_many :to_learns

  has_many :normal_profile_to_teaches, through: :to_learns, source: :normal_profile
  has_many :normal_profile_to_learns, through: :to_learns, source: :normal_profile
 
  #--------------------------------------------- MISC

  accepts_nested_attributes_for :image_cover, allow_destroy: true, reject_if: proc { |attributes| attributes['file'].blank? && attributes['id'].blank? }  
  accepts_nested_attributes_for :image_card_category, allow_destroy: true, reject_if: proc { |attributes| attributes['file'].blank? && attributes['id'].blank? } 

  #--------------------------------------------- VALIDATION

  #--------------------------------------------- CALLBACK

  #--------------------------------------------- SCOPES
  scope :order_default, -> { order('name ASC') }
  
  #--------------------------------------------- METHODS

  def avg_price
    500
  end


  def to_s
    name
  end

  def get_image_cover
    ((image_cover.nil?) || (!image_cover.persisted?))? '/perm_assets/images/product_default.png' : image_cover.file_with_relative_path
  end

  def get_image_cover_thumb
    ((image_cover.nil?) || (!image_cover.persisted?))? '/perm_assets/images/product_default.png' : image_cover.file_thumb_with_relative_path
  end



  def get_image_card_category
    ((image_card_category.nil?) || (!image_card_category.persisted?))? '/perm_assets/images/product_default.png' : image_card_category.file_with_relative_path
  end

  def get_image_card_category_thumb
    ((image_card_category.nil?) || (!image_card_category.persisted?))? '/perm_assets/images/product_default.png' : image_card_category.file_thumb_with_relative_path
  end


  def destroyable?
    workshops.empty? && to_teaches.empty? && to_learns.empty?
  end

end
