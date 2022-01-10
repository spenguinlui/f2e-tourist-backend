class AddAuthTokenOnSupplier < ActiveRecord::Migration[6.0]
  def change
    add_column :suppliers, :auth_token, :string, null: false
  end
end
