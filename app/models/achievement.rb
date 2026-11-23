class Achievement < ApplicationRecord
  belongs_to :student, optional: true
  has_many :images, -> { order(:position, :id) }, class_name: "AchievementImage", inverse_of: :achievement, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true, reject_if: ->(a) { a['image'].blank? && a['id'].blank? }

  mount_uploader :certificate, AchievementFileUploader
  mount_uploader :event_photo, AchievementFileUploader

  CATEGORIES = [
    ["Academic Achievements", "academic"],
    ["Sports Achievements", "sports"],
    ["Art & Craft Achievements", "art_craft"],
    ["Literary Achievements", "literary"],
    ["Music & Dance Achievements", "music_dance"],
    ["Alumni Achievements", "alumni"]
  ].freeze

  LEVELS = [
    ["School", "school"],
    ["Inter School", "inter_school"],
    ["District", "district"],
    ["State", "state"],
    ["National", "national"],
    ["International", "international"]
  ].freeze

  POSITIONS = [
    ["Gold / 1st", "gold"],
    ["Silver / 2nd", "silver"],
    ["Bronze / 3rd", "bronze"],
    ["Merit / Distinction", "merit"],
    ["Special Mention", "special"],
    ["Participation", "participation"]
  ].freeze

  validates :title, presence: true
  validates :category, inclusion: { in: CATEGORIES.map(&:last) }
  validates :level, inclusion: { in: LEVELS.map(&:last) }, allow_blank: true
  validates :position, inclusion: { in: POSITIONS.map(&:last) }, allow_blank: true

  before_validation :default_session

  scope :active, -> { where(is_active: true) }
  scope :featured, -> { where(is_featured: true) }
  scope :recent, -> { order(Arel.sql('event_date DESC NULLS LAST, created_at DESC')) }

  # Indian academic session: April to March, e.g. "2026-27".
  def self.session_for(date)
    date ||= Date.current
    start = date.month >= 4 ? date.year : date.year - 1
    "#{start}-#{(start + 1).to_s[-2..-1]}"
  end

  def self.label_for(list, value)
    list.find { |_, v| v == value }&.first
  end

  def category_label
    self.class.label_for(CATEGORIES, category)
  end

  def level_label
    self.class.label_for(LEVELS, level)
  end

  def position_label
    self.class.label_for(POSITIONS, position)
  end

  def achiever_name
    student&.name || team_name
  end

  # All photos for the slider: the main event photo first, then the extra gallery images.
  def photo_urls
    urls = []
    urls << event_photo.url if event_photo.url.present? && event_photo.image?
    urls + images.map { |i| i.image.url }.compact
  end

  # Used on the public page when the admin has not written a description.
  def auto_summary
    who = if student
            "#{student.name}#{" of Class #{student.class_label}" if student.class_label && !student.is_alumni}"
          elsif team_name.present?
            "our #{team_name}"
          end
    return nil unless who
    result = {
      'gold' => 'secured the First Position', 'silver' => 'secured the Second Position',
      'bronze' => 'secured the Third Position', 'merit' => 'earned a Merit / Distinction',
      'special' => 'received a Special Mention'
    }.fetch(position, 'participated')
    "Heartiest congratulations to #{who}, who #{result} in the #{title}#{" at the #{level_label} level" if level_label}#{" with #{score}" if score.present?}."
  end

  private

  def default_session
    self.academic_session = self.class.session_for(event_date) if academic_session.blank?
  end
end
