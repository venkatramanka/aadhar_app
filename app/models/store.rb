class Store < ActiveRecord::Base
  attr_accessible :name, :category_id, :line_1, :line_2, :city, :state,
  			:pincode, :phone, :email, :password, :verified
  
end
