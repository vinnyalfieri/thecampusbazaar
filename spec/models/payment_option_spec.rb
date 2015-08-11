require 'rails_helper'

RSpec.describe PaymentOption, type: :model do
  describe 'assocations' do
    
    let(:payment_option1){PaymentOption.new(name: 'venmo')}
    let(:offer1){Offer.new(offer_price: '1.50', status: 'accepted')}
    let(:offer2){Offer.new(offer_price: '3.50', status: 'accepted')}

    let(:seller){User.create(name: "Jake", email: "jake@jake.com", password: "abc")}
    let(:buyer){User.create(name: "Vinny", email: "vinny@vinny.com", password: "abc")}
    let(:item){Item.new}
    let(:item2){Item.new}
    let(:offer){Offer.new(offer_price: '1.50', status: status)}

    before do 
      item.seller = seller
      item2.seller = seller
      offer1.item = item
      offer1.buyer = buyer
      offer2.buyer = buyer
      offer2.item = item2
      offer1.payment_options << payment_option1
      offer2.payment_options << payment_option1
      offer1.save
      offer2.save
    end
    it 'has many offers' do 
      expect(payment_option1.offers).to include(offer1, offer2)
    end
  end
end
