class Comment < ApplicationRecord
  belongs_to :customer
  belongs_to :product
  has_many :notifications, dependent: :destroy
end
