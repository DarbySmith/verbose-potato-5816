require 'rails_helper'

RSpec.describe 'Item index' do
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
  
  it 'shows all the items with name, price, supermarket, and count of customers that bought the item' do
    visit "/items"

    within("#item-#{@item_1.id}") do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.price)
      expect(page).to have_content(@market_1.name)
      expect(page).to have_content(@item_1.customer_count)
    end
    
    within("#item-#{@item_2.id}") do
      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@item_2.price)
      expect(page).to have_content(@market_1.name)
      expect(page).to have_content(@item_2.customer_count)
    end

    within("#item-#{@item_3.id}") do
      expect(page).to have_content(@item_3.name)
      expect(page).to have_content(@item_3.price)
      expect(page).to have_content(@market_1.name)
      expect(page).to have_content(@item_3.customer_count)
    end

    within("#item-#{@item_4.id}") do
      expect(page).to have_content(@item_4.name)
      expect(page).to have_content(@item_4.price)
      expect(page).to have_content(@market_1.name)
      expect(page).to have_content(@item_4.customer_count)
    end

    within("#item-#{@item_5.id}") do
      expect(page).to have_content(@item_5.name)
      expect(page).to have_content(@item_5.price)
      expect(page).to have_content(@market_1.name)
      expect(page).to have_content(@item_5.customer_count)
    end

    expect(page).to_not have_content(@market_2.name)
    expect(page).to_not have_content(@customer_1.name)
  end
end