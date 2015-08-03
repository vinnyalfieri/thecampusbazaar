require 'rails_helper'

# RSpec.describe Category, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end


describe Category do
  describe 'associations' do
    it 'has a name' do
      expect(@furniture.name).to eq("Furniture") 
    end

    it 'has many items' do
      expect(@furniture.items).to include(@umbrella) 
    end
    
  end
end