# Used for both the certificate (image or PDF) and the event photo of an achievement.
class AchievementFileUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_allowlist
    %w(jpg jpeg png gif webp pdf)
  end

  def image?
    file.present? && %w(jpg jpeg png gif webp).include?(file.extension.to_s.downcase)
  end
end
