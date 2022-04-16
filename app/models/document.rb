class Document < ApplicationRecord
  mount_uploader :file, DocumentUploader
  DOCUMENT_TYPES = [
    ["Fee structure", "fee_structure"],
    ["Affiliation letter", "affiliation_letter"],
    ["Society/Trust Registration Certificate", "society_registration_certificate"],
    ["No Objection Certificate", "noc"],
    ["Recognition Certificate Under RTE Act-2009", "recognition_certificate"],
    ["Building safety certificate", "building_safety_certificate"],
    ["Fire safety certificate", "fire_safety_certificate"],
    ["DEO Certificate for Affiliation", "deo_certificate"],
    ["Water sanitation certificate", "water_sanitation_certificate"],
    ["Academic calendar", "academic_calendar"],
    ["Book List with Declaration", "book_list"],
    ["Last three year results", "last_three_year_results"],
    ["Committee of the School", "committee"],
    ["School committees structre", "committees"],
    ["Norms of fixing fee", "norms_of_fixing_fee"],
  ]

  validates :name, presence: true
  validates :file, presence: true
end
