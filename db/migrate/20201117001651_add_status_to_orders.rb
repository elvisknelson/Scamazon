class AddStatusToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :status, :string
    add_column :orders, :hst_paid, :decimal
  end
end
