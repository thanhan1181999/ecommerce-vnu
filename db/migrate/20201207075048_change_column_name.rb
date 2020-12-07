class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :comments, :orders_id, :order_id
  end
end
