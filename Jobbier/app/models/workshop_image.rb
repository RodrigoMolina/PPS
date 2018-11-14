class WorkshopImage < ApplicationRecord

  include Destroyable

  #--------------------------------------------- RELATION
  belongs_to :workshop
  belongs_to :image, dependent: :destroy

  #--------------------------------------------- MISC
  accepts_nested_attributes_for :image, allow_destroy: true, reject_if: lambda {|attributes| attributes['file_cache'].blank? && attributes['file'].blank? && attributes['id'].blank? }



  #--------------------------------------------- VALIDATION
  validates :kind, :image, presence: true

  #--------------------------------------------- CALLBACK

  #--------------------------------------------- SCOPES
  scope :kind_normal, -> { where(kind: :normal) }
  scope :kind_place, -> { where(kind: :place) }

  #--------------------------------------------- METHODS
  def get_image
    ((image.nil?) || (image.file.nil?))? 'workshop_default.png' : image.file_with_relative_path
  end

  def get_image_thumb
    ((image.nil?) || (image.file.nil?))? 'workshop_default.png' : image.file_thumb_with_relative_path
  end

  def high_or_wide
    if image.nil?
      'high'
    else
      image.high_or_wide
    end
  end

end
