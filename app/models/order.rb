class Order < ApplicationRecord
  has_many :product_orders
  validates :total_price, :pst_paid, :gst_paid, :hst_paid, numericality: true
  validates :user_id, :total_price, :pst_paid, :gst_paid, :status, :hst_paid, presence: true
end
