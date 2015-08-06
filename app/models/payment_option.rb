class PaymentOption < ActiveRecord::Base
  has_many :offer_payment_options
  has_many :offers, through: :offer_payment_options
end
