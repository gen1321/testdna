class DocumentUploader < CarrierWave::Uploader::Base
  storage :fog

  def extension_whitelist
    %w[jpg jpeg gif png pdf]
  end
end
