class CreateSummerHomeworks < ActiveRecord::Migration[5.2]
  def change
    create_table :summer_homeworks do |t|
      t.string :class_name
      t.string :homework_doc

      t.timestamps
    end
  end
end
