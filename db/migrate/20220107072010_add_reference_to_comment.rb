class AddReferenceToComment < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :user, index: true
    add_reference :comments, :local_item, index: true
  end
end
