class AddUserIdToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :user, index: true, foreign_key: true
    add_index :products, [:user_id, :created_at]
  end
end
