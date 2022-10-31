require 'rails_helper'

# Story 1

# As a visitor, 
# When I visit a customer show page,
# I see the customer's name,
# And I see its a list of its items
# including the item's name, price, and the name of the supermarket that it belongs to.

RSpec.describe 'Customer Show Page' do
  it 'should have the customers name and list of items including their name, price and supermarket it belongs to' do
    customer_1 = Customer.create!(name: 'Mark Arum')
    customer_2 = Customer.create!(name: 'Shelly Winter')
    customer_3 = Customer.create!(name: 'Eric Ericson')
    
    market_1 = Supermarket.create!(name: 'Publix', location: 'Atlanta, GA')
    market_2 = Supermarket.create!(name: 'Kroger', location: 'Duluth, GA')

    item_1 = market_1.items.create!(name: 'Pasta', price: 1)
    item_2 = market_1.items.create!(name: 'Salami', price: 5)
    item_3 = market_1.items.create!(name: 'Watermelon', price: 4)
    item_4 = market_1.items.create!(name: 'Broccoli', price: 2)
    item_5 = market_1.items.create!(name: 'Apple', price: 1)

    customer_item_1 = CustomerItem.create!(customer: customer_1, item: item_1)
    customer_item_2 = CustomerItem.create!(customer: customer_1, item: item_3)
    customer_item_3 = CustomerItem.create!(customer: customer_1, item: item_4)
    customer_item_4 = CustomerItem.create!(customer: customer_2, item: item_1)
    customer_item_5 = CustomerItem.create!(customer: customer_2, item: item_2)

    visit "/customers/#{customer_1.id}"

    expect(page).to have_content(customer_1.name)
    
    within("#item-#{item_1.id}") do
      expect(page).to have_content(item_1.name)
      expect(page).to have_content(item_1.price)
      expect(page).to have_content(market_1.name)
    end

    within("#item-#{item_3.id}") do
      expect(page).to have_content(item_3.name)
      expect(page).to have_content(item_3.price)
      expect(page).to have_content(market_1.name)
    end 

    within("#item-#{item_4.id}") do
      expect(page).to have_content(item_4.name)
      expect(page).to have_content(item_4.price)
      expect(page).to have_content(market_1.name)
    end 

    expect(page).to_not have_content(customer_2.name)
    expect(page).to_not have_content(market_2.name)
    expect(page).to_not have_content(item_2.name)
    save_and_open_page
  end
end