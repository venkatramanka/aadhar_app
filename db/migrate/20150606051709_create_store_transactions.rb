class CreateStoreTransactions < ActiveRecord::Migration
  def change
    create_table :store_transactions do |t|
      t.float :amount
      t.integer :user_id
      t.integer :store_id
      t.float :tax
      t.text :remarks
      t.timestamps
    end
  end
end
