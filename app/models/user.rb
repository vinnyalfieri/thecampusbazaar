class User < ActiveRecord::Base
  acts_as_messageable
  attr_accessor :delete_avatar
  attr_encrypted :token, :key => ENV['encrypt_key']
  belongs_to :community
  has_many :items, :foreign_key => 'seller_id'
  has_many :offers_sent, :class_name => "Offer", :foreign_key => 'buyer_id'
  validates :name, presence: true, format: { 
    with: /\A[a-zA-Z\s]+\z/,
    message: "only allows letters and spaces"
  }

  validates :email, presence: true, format: {
    with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
    message: "must be proper email format"
  }
  
  has_secure_password

  before_validation {avatar.clear if delete_avatar =='1'}

  has_attached_file :avatar, 
                    :styles => { :medium => "300x300>", 
                                 :thumb => "100x100>" },
                    :default_url => ActionController::Base.helpers.asset_path('placeholder-avatar.png')

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


  def has_venmo?
    self.venmo_id && self.encrypted_token
  end

  def mailboxer_email(object)
    email
  end

  def offers_sent
    Offer.all.select{ |offer| offer.buyer == self }
  end

  def pending_offers_sent
    Offer.all.select{ |offer| offer.buyer == self && offer.status == 'pending'}
  end

  def rejected_offers_sent
    Offer.all.select{ |offer| offer.buyer == self && offer.status == 'rejected'}
  end

  def accepted_offers_sent
    Offer.all.select{ |offer| offer.buyer == self && offer.status == 'accepted'}
  end
  
  def offers_received
    self.items.select{|item| item.offers}
  end

  def seller?
    !(self.items == [])
  end 

end
