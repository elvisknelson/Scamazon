class AddRatingToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :rating, :float
  end
end
