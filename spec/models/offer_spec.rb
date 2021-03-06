require 'rails_helper'

RSpec.describe Offer, type: :model do


  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'associations' do 

    
    let(:seller){User.new(name: 'Katie', email: "jake@jake.com", password: "abc", password_confirmation: "abc")}
    let(:buyer){User.new(name: 'Minling', email: 'minling@nyu.edu', password: '123', password_confirmation: '123')}
    let(:item){Item.new(name: 'Cup', price: '2.00', description: 'yay cups', condition: 'new')}
    let(:offer){Offer.new(offer_price: '1.50', status: 'pending')}
    let(:payment_option1){PaymentOption.new(name: 'venmo')} 
    let(:payment_option2){PaymentOption.new(name: 'cash')}


    before do 
      item.seller = seller
      offer.item = item
      offer.buyer = buyer
      offer.payment_options << payment_option1
      offer.payment_options << payment_option2
      offer.save
    end
    it 'belongs to a buyer' do 
      expect(offer.buyer).to eq(buyer)
    end

    it 'belongs to an item' do
      expect(offer.item).to eq(item)
    end

    it 'has a seller through item' do 
      expect(offer.seller).to eq(seller)
    end

    it 'has many payment options' do 
      expect(offer.payment_options).to include(payment_option1, payment_option2)
    end
  end

  describe 'validations' do 

    let(:seller){User.create(name: "Jake", email: "jake@jake.com", password: "abc")}
    let(:buyer){User.create(name: "Vinny", email: "vinny@vinny.com", password: "abc")}
    let(:item){Item.new}
    let(:offer){Offer.new(offer_price: '1.50', status: status)}

    let(:status){}

    before(:each) do
      item.seller = seller
      offer.item = item
      offer.buyer = buyer
      offer.save
    end

    it 'has a default status of "pending"' do 
      expect(Offer.new.status).to eq("pending")
    end
    
    context 'when user does not have a valid status' do 
      let(:status){'open'}
      it 'it is an invalid status' do 
        
        expect(offer).to be_invalid
      end
    end

    context 'when user has a valid status' do 
      let(:status){'accepted'}
      it 'it is an valid status' do 
        expect(offer).to be_valid
      end
    end
  end


end
