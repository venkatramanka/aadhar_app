class AddVerifiedToStore < ActiveRecord::Migration
  def change
    add_column :stores, :verified, :boolean
  end
end
