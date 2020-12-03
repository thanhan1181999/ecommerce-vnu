class ChangeColumnSale < ActiveRecord::Migration[6.0]
  def change
    rename_column :sales, :products_id, :product_id
  end
end
