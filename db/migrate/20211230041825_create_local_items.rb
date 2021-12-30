class CreateLocalItems < ActiveRecord::Migration[6.0]
  def change
    create_table :local_items do |t|
      t.string :ptx_data_id, null: false
      t.string :ptx_data_type
      t.text :feature

      t.integer :search_count, default: 0
      t.integer :enter_count, default: 0
      t.integer :favorite_count, default: 0

      t.timestamps
    end
  end
end
