class CreateStoreCategories < ActiveRecord::Migration
  def change
    create_table :store_categories do |t|
    	t.string :name
    	t.float :tax_percent
      t.timestamps
    end
  end
end
