class GalleryVideo < ApplicationRecord
  mount_uploader :video, GalleryVideoUploader

  validates :title, presence: true
  validates :video, presence: true
end
