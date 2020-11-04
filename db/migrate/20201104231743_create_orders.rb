class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.decimal :total_price
      t.decimal :pst_paid
      t.decimal :gst_paid

      t.timestamps
    end
  end
end
