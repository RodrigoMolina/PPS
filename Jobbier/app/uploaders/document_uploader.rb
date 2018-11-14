class DocumentUploader < CarrierWave::Uploader::Base



  storage :file

  def filename
    file.filename
  end
  
  def file_with_relative_path
    if self.model.persisted?
      "/uploads/#{model.class.to_s.underscore}/#{mounted_as}_#{model.id}/#{file.filename}"
    else
      "/uploads/tmp/#{cache_id}/#{filename}"
    end
  end

  def file_thumb_with_relative_path
    if self.model.persisted?
      "/uploads/#{model.class.to_s.underscore}/#{mounted_as}_#{model.id}/#{thumb.file.filename}"
    else
      "/uploads/tmp/#{cache_id}/#{filename}"
    end
  end

  def extension_white_list
    #acepta todo
  end

  def store_dir
    Rails.root.to_s+"/public/uploads/#{model.class.to_s.underscore}/#{mounted_as}_#{model.id}"
  end

  def extension
    file.extension
  end

  def extension?(array)
    array.include?(extension)
  end



end
