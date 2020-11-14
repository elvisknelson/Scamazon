ActiveAdmin.register Contact do
  permit_params :header, :content, :name, :email, :address, :footer
end
