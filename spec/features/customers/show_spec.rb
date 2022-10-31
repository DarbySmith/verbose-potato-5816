require 'rails_helper'

# Story 1

# As a visitor, 
# When I visit a customer show page,
# I see the customer's name,
# And I see its a list of its items
# including the item's name, price, and the name of the supermarket that it belongs to.

RSpec.describe 'Customer Show Page' do
  before(:each) do
    @customer_1 = Customer.create!(name: 'Mark Arum')
    @customer_2 = Customer.create!(name: 'Shelly Winter')
    @customer_3 = Customer.create!(name: 'Eric Ericson')
    
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
  end 

  it 'should have the customers name and list of items including their name, price and supermarket it belongs to' do

    visit "/customers/#{@customer_1.id}"

    expect(page).to have_content(@customer_1.name)
    
    within("#item-#{@item_1.id}") do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.price)
      expect(page).to have_content(@market_1.name)
    end

    within("#item-#{@item_3.id}") do
      expect(page).to have_content(@item_3.name)
      expect(page).to have_content(@item_3.price)
      expect(page).to have_content(@market_1.name)
    end 

    within("#item-#{@item_4.id}") do
      expect(page).to have_content(@item_4.name)
      expect(page).to have_content(@item_4.price)
      expect(page).to have_content(@market_1.name)
    end 

    expect(page).to_not have_content(@customer_2.name)
    expect(page).to_not have_content(@market_2.name)
    expect(page).to_not have_content(@item_2.name)
  end

  # As a visitor,
  # When I visit a customer's show page,
  # Then I see a form to add an item to this customer.
  # When I fill in a field with the id of an existing item,
  # And I click submit,
  # Then I am redirected back to the customer's show page, 
  # And I see the item now listed under this customer's items.
  # (You do not have to test for a sad path, for example if the ID submitted is not an existing item)

  it 'has a form to add an existing item by id to the customer' do
    visit "/customers/#{@customer_1.id}"

    expect(page).to have_field(:item_id)
    
    fill_in :item_id, with: @item_2.id
    click_on "Add Item"

    expect(current_path).to eq("/customers/#{@customer_1.id}")
    
    within("#item-#{@item_2.id}") do
      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@item_2.price)
      expect(page).to have_content(@market_1.name)
    end

    expect(page).to_not have_content(@market_2.name)
    expect(page).to_not have_content(@item_5.name)
    expect(page).to_not have_content(@customer_2.name)
  end
end