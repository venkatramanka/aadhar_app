class StoreCategory < ActiveRecord::Base
  attr_accessible :name, :tax_percent

  has_many :stores, :class_name => "Store", foreign_key: :category_id
  def get_tax(amount)
    amount*tax_percent/100
  end
end
