class Supermarket < ApplicationRecord
  validates_presence_of :name, :location
  has_many :items

  # def list_customers
  #   require 'pry'; binding.pry
  #   self.itmes.select
  # end
end