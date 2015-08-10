class Offer < ActiveRecord::Base
  belongs_to :buyer, :class_name => 'User'
  belongs_to :item
  delegate :seller, to: :item
  has_many :offer_payment_options
  has_many :payment_options, through: :offer_payment_options

  validates :status, inclusion: { in: %w(accepted rejected pending), message: "%{value} is not valid"}

  validate :not_own_item

  def self.pending_offers(item_id)
    Item.find(item_id).offers.select{ |offer| offer.status == 'pending'}
  end 

  private
    def not_own_item
      if seller.id == buyer.id
        errors.add(:base, "Seller cannot purchase their own listing.")
      end
    end

end
