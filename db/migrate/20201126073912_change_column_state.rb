class ChangeColumnState < ActiveRecord::Migration[6.0]
  def change
    change_column :orders, :state, :string, default: "waiting_accept" 
  end
end
