require 'rails_helper'

RSpec.describe PaymentOption, type: :model do
  describe 'assocations' do
    let(:payment_option1){PaymentOption.new(name: 'venmo')}
    let(:offer1){Offer.new(offer_price: '1.50', status: 'accepted')}
    let(:offer2){Offer.new(offer_price: '3.50', status: 'accepted')}
    before do 
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
