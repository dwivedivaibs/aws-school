class Document < ApplicationRecord
  mount_uploader :file, DocumentUploader
  DOCUMENT_TYPES = [
    ["Fee structure", "fee_structure"],
    ["Land Certificate", "land_certificate"],
    ["OASIS Document", "oasis"],
    ["Affiliation letter", "affiliation_letter"],
    ["Academic Calendar", "academic_calendar"],
    ["Society/Trust Registration Certificate", "society_registration_certificate"],
    ["No Objection Certificate", "noc"],
    ["Staff Details", "staff_details"],
    ["Recognition Certificate", "recognition_certificate"],
    ["Building safety certificate", "building_safety_certificate"],
    ["Fire safety certificate", "fire_safety_certificate"],
    ["DEO Certificate for Affiliation", "deo_certificate"],
    ["Public Disclosure", "public_disclosure"],
    ["Water sanitation certificate", "water_sanitation_certificate"],
    ["Academic calendar", "academic_calendar"],
    ["Book List with Declaration", "book_list"],
    ["Last three year results", "last_three_year_results"],
    ["Official of Different Committee of the School", "committee"],
    ["School committees stracture", "committee_stracture"],
    ["Norms of fixing fee", "norms_of_fixing_fee"],
    ["PROSPECTUS", "prospectus"],
    ["Student Details", "student_details"]
  ]

  validates :name, presence: true
  validates :file, presence: true
end
