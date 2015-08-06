class OfferPaymentOption < ActiveRecord::Base
  belongs_to :offer
  belongs_to :payment_option
end
