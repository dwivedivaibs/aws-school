class CreateTcEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :tc_entries do |t|
      t.string :tc_number
      t.string :student_name
      t.string :father_name
      t.string :mother_name
      t.string :nationality
      t.boolean :sc_st_obc
      t.datetime :dob
      t.string :result
      t.string :subjects
      t.string :last_class
      t.string :last_class_result
      t.boolean :qualified_for_promotion
      t.boolean :dues_paid
      t.boolean :ncc_cadets
      t.datetime :last_day_school
      t.string :leaving_reason
      t.string :total_meeting_attendance
      t.string :total_attendance
      t.string :general_conduct
      t.string :category
      t.datetime :certificate_issue_date

      t.timestamps
    end
    TcEntry.create!(tc_number: "AWS-123", student_name: "Vaibhav Dwivedi", father_name: "Pramod Kumar", mother_name: "Usha Dwivedi", nationality: "Indian", sc_st_obc: 0, dob: (Time.now-15.year), result: "Pass", subjects: "English, Math, Science, Hindi, SST", last_class: "IX", last_class_result: "Passed", qualified_for_promotion: 1, dues_paid: 0, ncc_cadets: 1, last_day_school: (Time.now-2.days), leaving_reason: "Parents Transfer", total_meeting_attendance: "150", total_attendance: "100", general_conduct: "Very Good", category: "INDEPENDENT Category", certificate_issue_date: Date.today)
  end
end
