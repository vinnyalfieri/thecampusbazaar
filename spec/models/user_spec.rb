require 'rails_helper'

# RSpec.describe User, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# 

describe User do
  describe 'associations' do
    it 'has a name' do
      expect(@katie.name).to eq("Katie") 
    end

    it 'as a seller has many items' do
      expect(@katie.items).to include(@umbrella) 
    end

    it 'belongs to a community' do
      expect(@katie.community).to eq(@community1)
    end
    
  end
end
