ActiveAdmin.register Order do
  permit_params :user_id, :total_price, :pst_paid, :gst_paid, :status, :hst_paid, :stripe_id
end
