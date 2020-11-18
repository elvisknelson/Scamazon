class Order < ApplicationRecord
  has_many :product_orders
end
