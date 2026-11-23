class CreateAchievementImages < ActiveRecord::Migration[5.2]
  def change
    create_table :achievement_images do |t|
      t.references :achievement, foreign_key: true, null: false
      t.string  :image
      t.integer :position, default: 0
      t.timestamps
    end
  end
end
