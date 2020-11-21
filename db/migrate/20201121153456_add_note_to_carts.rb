class AddNoteToCarts < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :note, :text
  end
end
