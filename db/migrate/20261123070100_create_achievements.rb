class CreateAchievements < ActiveRecord::Migration[5.2]
  def change
    create_table :achievements do |t|
      t.references :student, foreign_key: true, null: true
      t.string  :team_name
      t.string  :title, null: false
      t.string  :category, null: false
      t.string  :level
      t.string  :position
      t.string  :score
      t.date    :event_date
      t.string  :academic_session
      t.text    :description
      t.string  :certificate
      t.string  :event_photo
      t.boolean :is_featured, default: false
      t.boolean :is_active, default: true
      t.timestamps
    end
    add_index :achievements, :category
    add_index :achievements, :academic_session
  end
end
