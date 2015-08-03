require 'rails_helper'

# RSpec.describe Category, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end


describe Category do
  describe 'associations' do


    let(:umbrella){Item.new(name:'Umbrella')}
    let(:shelf){Item.new(name:'Shelf')}
    let(:furniture){Category.new(name:'furniture')}

    context 'when an item receives another category' do 

      it 'has many items' do
        umbrella.categories << furniture
        shelf.categories << furniture
        umbrella.save
        shelf.save
        expect(furniture.items).to include(umbrella)
        expect(furniture.items).to include(shelf)
      end
    end
    
  end

  describe 'validations' do
    let(:category){Category.new(name: name)}
    context 'when a category has name' do
      let(:name){"furniture"}

      it 'is valid' do 
        expect(category).to be_valid
      end

    end

    context 'when a category does not have a name' do
      let(:name){""}
      it 'is invalid' do
        expect(category).to be_invalid
      end
    end
  end
end