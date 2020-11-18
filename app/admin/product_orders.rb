ActiveAdmin.register ProductOrder do
  permit_params :product_id, :order_id, :quantity
end
