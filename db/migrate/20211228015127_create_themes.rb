class CreateThemes < ActiveRecord::Migration[6.0]
  def change
    create_table :themes do |t|
      t.string :theme_name, null: false
      t.string :theme_tags, array: true

      t.timestamps
    end
  end
end
