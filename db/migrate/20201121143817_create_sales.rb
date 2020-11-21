class CreateSales < ActiveRecord::Migration[6.0]
  def change
    create_table :sales do |t|
      t.integer :promotion
      t.integer :quantity
      t.date :from
      t.date :to
      t.references :products, null: false, foreign_key: true

      t.timestamps
    end
  end
end
