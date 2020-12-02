class RemoveFieldNameFromAll < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :image, :string
    remove_column :comments, :image, :string
    remove_column :categories, :image, :string
    remove_column :products, :image, :string
    remove_column :stores, :image, :string
  end
end
