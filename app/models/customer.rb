class Customer < ApplicationRecord
  validates_presence_of :name
  has_many :customer_items
  has_many :items, through: :customer_items
end