class RemoveFieldNameFromStores < ActiveRecord::Migration[6.0]
  def change
    remove_column :stores, :image, :string
  end
end
