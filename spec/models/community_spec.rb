require 'rails_helper'

# RSpec.describe Community, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end


describe Community do
  describe 'associations' do
    it 'has a name' do
      expect(@community1.name).to eq("NYU") 
    end

    it 'has many sellers' do
      expect(@community1.sellers).to include(@katie) 
    end

    it 'has many items through seller' do
      expect(@community1.items).to include(@umbrella)
    end

    it 'has many categories through items' do 
      expect(@community1.categories).to include(@furniture)
    end
  end
end
