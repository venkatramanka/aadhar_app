class StoreTransaction < ActiveRecord::Base
  attr_accessible :amount, :user_id, :store_id, :tax, :remarks
end
