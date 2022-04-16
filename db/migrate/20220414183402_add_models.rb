class AddModels < ActiveRecord::Migration[5.2]
  def change
    create_table :gallery_images do |t|
      t.string :section
      t.string :image
      t.boolean :is_active, default: true

      t.timestamps
    end

    create_table :gallery_videos do |t|
      t.string :video
      t.boolean :is_active, default: true

      t.timestamps
    end

    create_table :documents do |t|
      t.string :name
      t.string :file
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
