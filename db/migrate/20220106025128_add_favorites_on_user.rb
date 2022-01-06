class AddFavoritesOnUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :favorites, :string, array: true
  end
end
