require 'rails_helper'

# RSpec.describe User, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# 

describe User do
  describe 'associations' do

    let(:katie){
      User.create(name: 'Katie', email: "jake@jake.com")
    }

    let(:umbrella){Item.new(name: 'Umbrella')}
    let(:raincoat){Item.new(name: 'Raincoat')}

    let(:community){Community.new(name:'Flatiron School')}

    it 'as a seller has many items' do
      
      katie.items << umbrella
      katie.items << raincoat

      expect(katie.items).to include(umbrella)
      expect(katie.items).to include(raincoat)
    end

    it 'belongs to a community' do
      katie.community = community
      expect(katie.community).to eq(community)
    end
    
  end

  describe 'validations' do

    let(:user){
      User.new(name: name, 
        email: email)
    }

    let(:name) { 'jake'}
    let(:email) { 'jake@jake.com'}

    context 'when user has a valid name, email, and password' do
      it 'is valid ' do 
        expect(user).to be_valid
      end
    end

    context 'when user has a name with non-alphabetical character' do
      let(:name) { "JAKE!!!!" }

      it 'is invalid' do
        expect(user).to be_invalid
      end
    end

    context 'when user has an improperly formatted email' do
      let(:email) { "an email"}
      it 'is invalid' do
        expect(user).to be_invalid
      end
    end

  end
end
