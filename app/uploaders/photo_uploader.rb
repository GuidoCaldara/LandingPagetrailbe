class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  process eager: true  # Force version generation at upload time.

  process convert: 'jpg'

  version :normal do
    resize_to_fit 800, 800
  end
  version :small do
    resize_to_fit 300, 300
  end
end
