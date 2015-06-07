class UserTransaction < ActiveRecord::Base
  attr_accessible :amount, :user_id, :to_user_id, :remarks
end
