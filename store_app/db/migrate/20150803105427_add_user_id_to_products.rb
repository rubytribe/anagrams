class AddUserIdToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :user, index: true
    add_foreign_key :products, :users
    add_index :products, [:user_id, :created_at]
  end
end
