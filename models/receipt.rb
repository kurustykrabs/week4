class Receipt < ActiveRecord::Base
  has_many :products
end
