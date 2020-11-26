class ChangeColumnStoreId < ActiveRecord::Migration[6.0]
  def change
    rename_column :products, :stores_id, :store_id
  end
end
