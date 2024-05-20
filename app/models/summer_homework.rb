class SummerHomework < ApplicationRecord
  mount_uploader :homework_doc, HomeworkDocUploader

  CLASS_NAME = [
    ["NURSERY"],
    ["LKG"],
    ["UKG"],
    ["1st"],
    ["2nd"],
    ["3rd"],
    ["4th"],
    ["5th"],
    ["6th"],
    ["7th"],
    ["8th"],
    ["9th"],
    ["10th"],
    ["11th"],
    ["12th"]
  ]

end
