class AddStateToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :state, :integer
  end
end
