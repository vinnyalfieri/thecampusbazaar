require 'rails_helper'

# RSpec.describe Community, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end


describe Community do
  describe 'associations' do

    let(:katie) { User.new(name: 'Katie', email: "jake@jake.com")}
    let(:umbrella) { Item.new(name:'Umbrella')}
    let(:community) { Community.new(name: 'NYU')}
    let(:furniture) { Category.new(name: "furniture")}
    let(:kitchen) { Category.new(name: "kitchen")}

    before do
      katie.community = community
      umbrella.categories << furniture
      umbrella.categories << kitchen
      katie.items << umbrella
      katie.save
    end

    it 'has many sellers' do
      expect(community.sellers).to include(katie) 
    end

    it 'has many items through seller' do
      expect(community.items).to include(umbrella)
    end

    it 'has many categories through items' do 
      expect(community.categories).to include(furniture)
    end
  end

  describe 'validations' do

    let(:nyu){Community.new(name:name)}

    context 'when it has a name' do
      let(:name){"NYU"}

      it 'is valid' do
        expect(nyu).to be_valid
      end
    end

    context 'when it does not have a name' do
      let(:name){""}
      it 'is invalid' do
        expect(nyu).to be_invalid
      end
    end

  end
end
