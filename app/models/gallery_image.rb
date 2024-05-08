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
    ["Laboratory Photo", "laboratory_photo"],
    ["AC Classroom", "ac_classroom"],
    ["Smart Class", "smart_class"],
    ["Sports Area", "sports_area"],
    ["Infrastructure", "infrastructure"],
    ["IT Lab", "it_lab"],
    ["Play Arena", "play_arena"],
    ["CCTV", "cctv"],
    ["Hotel & Mess", "hostel_and_mess"]
  ]

  scope :active, -> { where(is_active: true) }

  validates :image, presence: true
end
