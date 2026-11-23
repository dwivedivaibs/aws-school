class AchievementImage < ApplicationRecord
  belongs_to :achievement, inverse_of: :images
  mount_uploader :image, AchievementImageUploader
  validates :image, presence: true
end
