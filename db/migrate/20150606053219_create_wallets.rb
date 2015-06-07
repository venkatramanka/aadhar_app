class CreateWallets < ActiveRecord::Migration
  def change
    create_table :wallets do |t|
    	t.integer :owner_id
    	t.float :balance
      t.timestamps
    end
  end
end
