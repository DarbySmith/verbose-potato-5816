require 'rails_helper'

RSpec.describe Customer do
  describe 'relationships' do
    it { should have_many :customer_items}
    it { should have_many(:items).through(:customer_items)}
  end

  describe 'validations' do
    it { should validate_presence_of :name}
  end
end