class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :star
      t.text :content
      t.string :image
      t.references :orders, null: false, foreign_key: true

      t.timestamps
    end
  end
end
