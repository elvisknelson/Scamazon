ActiveAdmin.register User do
  permit_params :province_id, :username, :password, :street_address
end
