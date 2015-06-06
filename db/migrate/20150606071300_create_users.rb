class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :id
      t.string :aadhar_number
      t.string :name
      t.string :gender
      t.date :dob
      t.text :address
      t.string :mobile_number
      t.string :email
      t.string :password

      t.timestamps
    end
  end
end
