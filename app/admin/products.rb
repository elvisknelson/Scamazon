ActiveAdmin.register Product do
  permit_params :name, :price, :quantity
end
