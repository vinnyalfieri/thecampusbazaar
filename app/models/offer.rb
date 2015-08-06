class Offer < ActiveRecord::Base
  belongs_to :buyer, :class_name => 'User'
  belongs_to :item
  delegate :seller, to: :item
  has_many :offer_payment_options
  has_many :payment_options, through: :offer_payment_options

  validates :status, inclusion: { in: %w(accepted rejected pending), message: "%{value} is not valid"}
end
