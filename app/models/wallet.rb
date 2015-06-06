class Wallet < ActiveRecord::Base
  attr_accessible :owner_id, :type, :balance
  belongs_to :user
end
