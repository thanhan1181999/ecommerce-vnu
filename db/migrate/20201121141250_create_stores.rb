class CreateStores < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :image
      t.text :describe
      t.belongs_to :user

      t.timestamps
    end
  end
end
