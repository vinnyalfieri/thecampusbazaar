class Offer < ActiveRecord::Base
  belongs_to :buyer, :class_name => 'User'
  belongs_to :item
  delegate :seller, to: :item
  has_many :offer_payment_options
  has_many :payment_options, through: :offer_payment_options

  validates :status, inclusion: { in: %w(accepted rejected pending), message: "%{value} is not valid"}

  validate :not_own_item

  def charge_venmo
    note =  "Just bought #{self.item.name} from #{self.seller.name} on CampusBazaar"
    amount = self.offer_price# '-0.20'#
    VenmoWrapper.new.transfer_money_from(buyer,seller,amount,note)
  end

  def self.pending_offers(item_id)
    Item.find(item_id).offers.select{ |offer| offer.status == 'pending'}
  end 

  def settle
    self.status = 'accepted'
    save
    reject_offers(item_id)
  end

  private
    def not_own_item
      if seller.id == buyer.id
        errors.add(:base, "Seller cannot purchase their own listing.")
      end
    end

    def reject_offers(item_id)
      offers = Offer.pending_offers(item_id)
      offers.each do |offer|
        offer.status = 'rejected'
        offer.save
      end 
    end
end
