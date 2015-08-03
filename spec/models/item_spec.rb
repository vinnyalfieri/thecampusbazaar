require 'rails_helper'

# RSpec.describe Item, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

describe Item do
  describe 'associations' do
    it 'has a name' do
      expect(@umbrella.name).to eq("Umbrella") 
    end

    it 'belongs to a seller' do
      expect(@umbrella.seller).to eq(@katie) 
    end

    it 'belongs to a community through a seller' do
      expect(@umbrella.community).to eq(@community1)
    end

    it 'has many categories' do 
      expect(@umbrella.categories).to include(@furniture)
      expect(@umbrella.categories).to include(@kitchen)
    end
  end
end