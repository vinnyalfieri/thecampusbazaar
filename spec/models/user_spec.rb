require 'rails_helper'

# RSpec.describe User, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# 

RSpec.describe User do
  describe 'associations' do

    let(:katie){
      User.create(name: 'Katie', email: "jake@jake.com", password: "abc", password_confirmation: "abc")
    }

    let(:jim){
      User.create(name: 'Jim', email: "jim@jim.com", password: "abc", password_confirmation: "abc")
    }

    let(:umbrella){Item.new(name: 'Umbrella')}
    let(:raincoat){Item.new(name: 'Raincoat')}

    let(:community){Community.new(name:'Flatiron School')}

    let(:umbrella_offer) {Offer.new(offer_price: 2.31, status: "pending")}
    let(:raincoat_offer) {Offer.new(offer_price: 5.55, status: "rejected")}

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

    it 'can make offers on other user\'s items' do
      katie.items << umbrella
      umbrella_offer.buyer = jim
      umbrella_offer.item = umbrella
      umbrella_offer.save

      expect(jim.offers_sent.first.seller).to eq(katie)
    end

    it 'has offers for its items' do
      katie.items << umbrella
      umbrella_offer.buyer = jim
      umbrella_offer.item = umbrella
      umbrella_offer.save
      expect(katie.offers_received).to include(umbrella_offer)
    end

    it 'cannot make an offer on its own item' do 
      katie.items << umbrella
      umbrella_offer.buyer = katie
      umbrella_offer.item = umbrella
      expect(umbrella_offer.save).to eq false
      expect(katie.offers_received).to_not include(umbrella_offer)
      expect(katie.offers_sent).to_not include(umbrella_offer)
    end
    
  end

  describe 'validations' do

    let(:user){
      User.new(name: name, 
        email: email,
        password: "abc", 
        password_confirmation: "abc")
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
