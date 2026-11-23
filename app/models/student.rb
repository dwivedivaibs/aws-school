class Student < ApplicationRecord
  mount_uploader :photo, StudentPhotoUploader

  CLASSES = %w(NURSERY LKG UKG 1st 2nd 3rd 4th 5th 6th 7th 8th 9th 10th 11th 12th).freeze
  HOUSES  = %w(Red Blue Green Yellow).freeze

  has_many :achievements, dependent: :destroy
  accepts_nested_attributes_for :achievements, allow_destroy: true,
    reject_if: ->(attrs) { attrs['title'].blank? }

  validates :name, presence: true

  scope :active, -> { where(is_active: true) }

  def class_label
    return "Alumni#{" (#{passing_year})" if passing_year.present?}" if is_alumni
    [student_class, section].reject(&:blank?).join(' - ').presence
  end

  def display_name
    [name, class_label, admission_no.presence && "Adm. #{admission_no}"].compact.join(' | ')
  end

  def initials
    name.to_s.split.first(2).map { |w| w[0] }.join.upcase
  end
end
