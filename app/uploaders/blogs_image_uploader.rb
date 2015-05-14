class BlogsImageUploader < CarrierWave::Uploader::Base
  
  include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  
  storage :fog

  def default_url
    "/assets/#{['default_banner', version_name].compact.join('-')}.png"
  end

  def store_dir
    Rails.configuration.BLOG_IMG_UPLOAD_DIRECTORY  + "/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg png gif bmp tif tiff)
  end

  def delete!
    remove!
    remove_versions!
  end  

  def filename
    ivar = "@#{mounted_as}_secure_token"    
    token = model.instance_variable_get(ivar) or model.instance_variable_set(ivar, SecureRandom.hex(20/2))
    "#{model.id}_#{token}.png" if original_filename
  end

end