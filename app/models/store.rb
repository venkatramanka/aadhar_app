class Store < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:authentication_keys => [ :email ]

  belongs_to :store_category, :class_name => "StoreCategory", foreign_key: :category_id
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :category_id, :line_1, :line_2, :city, :state,
  			:pincode, :phone, :email, :password, :verified, :encrypted_password
  has_one :wallet, foreign_key: :owner_id

  def transfer_amount(user, total_amount)
    user.wallet.balance -= total_amount
    user.wallet.save!
    tax_amount = self.store_category.get_tax(total_amount)
    self.wallet.balance += (total_amount - tax_amount)
    self.wallet.save!
    tax_amount
  end

  def profile_incomplete?
    [email, line_1, line_2, city, state, category_id, name, pincode, phone].include?(nil)
  end
end
