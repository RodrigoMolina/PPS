class Archive < ApplicationRecord

  include Destroyable

  #--------------------------------------------- RELATION

  #--------------------------------------------- MISC
  
  #--------------------------------------------- VALIDATION

  #--------------------------------------------- CALLBACK

  #--------------------------------------------- SCOPES

  #--------------------------------------------- METHODS
  def height
    file.height
  end

  def width
    file.width
  end

  def store_dir
    file.store_dir
  end

  def filename
    file.filename
  end

  def file_with_relative_path
    file.file_with_relative_path
  end

  def file_thumb_with_relative_path
    file.file_thumb_with_relative_path
  end


end
