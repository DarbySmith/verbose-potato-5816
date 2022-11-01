class Supermarket < ApplicationRecord
  validates_presence_of :name, :location
  has_many :items

  def list_customers
    Customer.joins(:items, :customer_items).where("items.supermarket_id = #{self.id}").distinct
  end
end