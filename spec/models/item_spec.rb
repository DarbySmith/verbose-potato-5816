require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many :customer_items}
    it { should have_many(:customers).through(:customer_items)}
  end

  describe 'validations' do 
    it { should validate_presence_of :name}
    it { should validate_presence_of :price}
  end

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

  describe 'instance methods' do
    describe '#customer_count' do
      it 'shows the number of customers that bought the item' do
        expect(@item_1.customer_count).to eq(2)
      end
    end
  end
end 
