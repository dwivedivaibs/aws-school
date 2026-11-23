class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string  :name, null: false
      t.string  :admission_no
      t.string  :student_class
      t.string  :section
      t.string  :house
      t.string  :photo
      t.boolean :is_alumni, default: false
      t.string  :passing_year
      t.text    :bio
      t.boolean :is_active, default: true
      t.timestamps
    end
    add_index :students, :admission_no
    add_index :students, :name
  end
end
