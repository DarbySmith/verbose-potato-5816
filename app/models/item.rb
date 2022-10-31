class Item < ApplicationRecord
  validates_presence_of :name, :price
  belongs_to :supermarket
  has_many :customer_items
  has_many :customers, through: :customer_items

  def customer_count
    customers.count
  end
end