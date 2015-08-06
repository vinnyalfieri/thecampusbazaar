class Offer < ActiveRecord::Base
  belongs_to :buyer, :class_name => 'User'
  belongs_to :item
  belongs_to :seller, through: :item
  has_many :offer_payment_options
  has_many :payment_options, through: :offer_payment_options

end
