class GalleryImage < ApplicationRecord
  mount_uploader :image, GalleryImageUploader

  SECTION = [
    ["SLIDER", "slider"],
    ["Banner", "banner"],
    ["About Section", "about_section"],
    ["Photo Gallery", "photo_gallery"]
  ]

  scope :active, -> { where(is_active: true) }

  validates :image, presence: true
end
