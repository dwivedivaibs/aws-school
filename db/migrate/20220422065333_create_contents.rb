class CreateContents < ActiveRecord::Migration[5.2]
  def change
    create_table :contents do |t|
      t.text :description
      t.string :content_type

      t.timestamps
    end
  end
end
