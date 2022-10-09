class Favorite < ApplicationRecord

  belongs_to :customer
  belongs_to :product
  validates_uniqueness_of :product_id, scope: :customer_id
end
