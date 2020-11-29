class ChangeColumnUserIdToCart < ActiveRecord::Migration[6.0]
  def change
    rename_column :carts, :users_id, :user_id
  end
end
