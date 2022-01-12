class AddAuthTokenIndexOnSupplier < ActiveRecord::Migration[6.0]
  def change
    add_index :suppliers, :auth_token
  end
end
