class ChangeAndAddColumnInProduct < ActiveRecord::Migration[6.0]
  def change
    rename_column :products, :picture, :image
    rename_column :categories, :picture, :image

    add_column :products, :description, :string
    add_column :products, :quantityInStock, :integer
    add_column :products, :trademark, :string
    add_column :products, :origin, :string
    add_column :products, :sendFrom, :string
    add_reference :products, :stores
  end
end
