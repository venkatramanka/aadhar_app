class User < ActiveRecord::Base
  attr_accessible :aadhar_number, :address, :dob, :email, :gender, :id, :mobile_number, :name, :password
  has_one :wallet, foreign_key: :owner_id
end
