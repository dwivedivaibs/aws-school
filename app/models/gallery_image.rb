class GalleryImage < ApplicationRecord
  mount_uploader :image, GalleryImageUploader

  SECTION = [
    ["SLIDER", "slider"],
    ["Banner", "banner"],
    ["About Section", "about_section"],
    ["Photo Gallery", "photo_gallery"],
    ["Principal Photo", "principal_photo"],
    ["Director Photo", "director_photo"],
    ["Manager Photo", "manager_photo"],
    ["Library Photo", "library_photo"],
    ["Laboratory Photo", "laboratory_photo"]
  ]

  scope :active, -> { where(is_active: true) }

  validates :image, presence: true
end
