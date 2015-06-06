class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.integer :category_id
      t.string :line_1
      t.string :line_2
      t.string :city
      t.string :state
      t.integer :pincode
      t.string :phone
      t.string :email
      t.string :password
      t.timestamps
    end
  end
end
