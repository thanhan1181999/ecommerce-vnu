class ChangeColumnProductsidToCart < ActiveRecord::Migration[6.0]
  def change
    rename_column :carts, :products_id, :product_id
  end
end
