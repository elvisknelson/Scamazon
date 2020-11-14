class AddContentToAbout < ActiveRecord::Migration[6.0]
  def change
    add_column :abouts, :content, :string
  end
end
