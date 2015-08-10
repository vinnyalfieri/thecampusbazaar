class Offer < ActiveRecord::Base
  belongs_to :buyer, :class_name => 'User'
  belongs_to :item
  delegate :seller, to: :item
  has_many :offer_payment_options
  has_many :payment_options, through: :offer_payment_options

  validates :status, inclusion: { in: %w(accepted rejected pending), message: "%{value} is not valid"}

  validate :not_own_item

  def charge_venmo
    token = ENV['venmo_access_token'] #buyer.token
    seller_id = '1646418611666944551' #seller.venmo_id
    note =  "Just bought #{self.item.name} from CampusBazaar"
    amount = '0.10' #self.offer_price
    conn = Faraday.new(:url => 'https://api.venmo.com') do |faraday|
           faraday.request  :url_encoded 
           faraday.response :logger
           faraday.adapter  Faraday.default_adapter
           end

      response = conn.post '/v1/payments', { user_id: seller_id, amount: amount, note: note, access_token: token}
  end

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
