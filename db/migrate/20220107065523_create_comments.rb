class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :title
      t.integer :score
      t.string :content
      t.binary :avatar

      t.timestamps
    end
  end
end
