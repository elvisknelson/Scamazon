class Province < ApplicationRecord
  has_many :users

  validates :pst, :gst, :hst, numericality: true
  validates :name, :pst, :gst, :hst, presence: true
end
