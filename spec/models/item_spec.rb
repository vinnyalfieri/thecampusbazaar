require 'rails_helper'

# RSpec.describe Item, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

describe Item do
  describe 'associations' do

    context 'when a user creates a new item' do

      let(:umbrella) {Item.new(name: 'Umbrella')}
      let(:katie){User.new(name:"katie",email: "jake@jake.com")}
      let(:nyu){Community.new(name: 'NYU')}

      before(:each) do
        katie.community = nyu
        umbrella.seller = katie
        katie.save
      end

      it 'item belongs to a seller' do
        expect(umbrella.seller).to eq(katie) 
      end

      it 'belongs to a community through a seller' do
        expect(umbrella.community).to eq(nyu)
      end

      it 'has many categories' do 
        furniture = Category.new(name: 'Furniture')
        kitchen = Category.new(name: 'Kitchen')

        umbrella.categories << furniture
        umbrella.categories << kitchen
        expect(umbrella.categories).to include(furniture)
        expect(umbrella.categories).to include(kitchen)
      end

    end
  end

  describe 'validations' do

    let(:item){
      Item.new(name: name)
    }

    context 'when an item has a name' do

      let(:name) {"Jake"}

      it 'is valid' do
        expect(item).to be_valid
      end
    end

    context 'when an item does not have a name' do

      let(:name){}

      it 'is invalid' do
        expect(item).to be_invalid
      end
    end

  end
end