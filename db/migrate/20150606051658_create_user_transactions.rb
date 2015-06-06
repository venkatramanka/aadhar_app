class CreateUserTransactions < ActiveRecord::Migration
  def change
    create_table :user_transactions do |t|
      t.float :amount
      t.integer :user_id
      t.integer :to_user_id
      t.text :remarks
      t.timestamps
    end
  end
end
