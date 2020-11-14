class AddHeaderToAbout < ActiveRecord::Migration[6.0]
  def change
    add_column :abouts, :header, :string
  end
end
