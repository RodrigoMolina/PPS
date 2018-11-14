class Image < Archive

  #--------------------------------------------- RELATION

  #--------------------------------------------- MISC
  mount_uploader :file, ImageUploader

  #--------------------------------------------- VALIDATION

  #--------------------------------------------- CALLBACK

  #--------------------------------------------- SCOPES

  #--------------------------------------------- METHODS

  def high_or_wide
    if width > height
        'wide'
    else
        'high'
    end
  end
  
end
