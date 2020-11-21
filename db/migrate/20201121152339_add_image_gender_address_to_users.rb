class AddImageGenderAddressToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :image, :string
    add_column :users, :gender, :integer
    add_column :users, :address, :string
  end
end
