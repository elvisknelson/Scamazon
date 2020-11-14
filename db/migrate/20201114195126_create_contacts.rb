class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :header
      t.string :content
      t.string :name
      t.string :email
      t.string :address
      t.string :footer

      t.timestamps
    end
  end
end
