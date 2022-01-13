class CreateSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :settings do |t|
      t.string :attribute_name
      t.string :attribute_value

      t.timestamps
    end
  end
end
