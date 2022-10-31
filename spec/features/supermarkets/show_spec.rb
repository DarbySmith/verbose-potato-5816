require 'rails_helper'

RSpec.describe "Supermarket show page" do
  before(:each) do
    @customer_1 = Customer.create!(name: 'Mark Arum')
    @customer_2 = Customer.create!(name: 'Shelly Winter')
    @customer_3 = Customer.create!(name: 'Eric Ericson')
    @customer_4 = Customer.create!(name: 'Clark Howard')
    
    @market_1 = Supermarket.create!(name: 'Publix', location: 'Atlanta, GA')
    @market_2 = Supermarket.create!(name: 'Kroger', location: 'Duluth, GA')

    @item_1 = @market_1.items.create!(name: 'Pasta', price: 1)
    @item_2 = @market_1.items.create!(name: 'Salami', price: 5)
    @item_3 = @market_1.items.create!(name: 'Watermelon', price: 4)
    @item_4 = @market_1.items.create!(name: 'Broccoli', price: 2)
    @item_5 = @market_1.items.create!(name: 'Apple', price: 1)

    @customer_item_1 = CustomerItem.create!(customer: @customer_1, item: @item_1)
    @customer_item_2 = CustomerItem.create!(customer: @customer_1, item: @item_3)
    @customer_item_3 = CustomerItem.create!(customer: @customer_1, item: @item_4)
    @customer_item_4 = CustomerItem.create!(customer: @customer_2, item: @item_1)
    @customer_item_5 = CustomerItem.create!(customer: @customer_2, item: @item_2)
    @customer_item_5 = CustomerItem.create!(customer: @customer_3, item: @item_5)
    @customer_item_5 = CustomerItem.create!(customer: @customer_3, item: @item_3)
  end 
  # Extension

  # As a visitor,
  # When I visit a supermarket's show page,
  # Then I see a unique list of all customers that have shopped at the supermarket.

  xit 'has a unique list of all customers that have shopped at the supermarket' do
    visit "/supermarkets/#{@market_1.id}"

    expect(page).to have_content(@customer_1.name, count: 1)
    expect(page).to have_content(@customer_2.name, count: 1)
    expect(page).to have_content(@customer_3.name, count: 1)

    expect(page).to_not have_content(@customer_4.name)
  end
end