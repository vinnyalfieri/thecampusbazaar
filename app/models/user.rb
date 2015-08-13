class User < ActiveRecord::Base
  #acts_as_messageable
  attr_accessor :delete_avatar
  attr_encrypted :token, :key => ENV['encrypt_key']
  belongs_to :community
  has_many :items, :foreign_key => 'seller_id'
  has_many :offers_sent, :class_name => "Offer", :foreign_key => 'buyer_id'
  has_many :conversations, :foreign_key => 'user1_id'
  has_many :conversations, :foreign_key => 'user2_id'
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
                    :default_url => 'placeholder-avatar.png'
                    # :storage => :s3,
                    # :s3_permissions => "public-read",
                  # :path => ":filename",
                    #   :bucket => ENV['amazon_bucket'],
                    # :s3_credentials => {
                    #   :access_key_id => ENV['amazon_access_key'],
                    #   :secret_access_key => ENV['amazon_secret'],
                    # }

                  #   :s3_permissions => "public-read",
                  # :path => ":filename",
                  # :bucket => ENV['amazon_bucket']

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def conversations
    conversation_from_me = Conversation.where(:user1_id => self.id)
    conversation_for_me = Conversation.where(:user2_id => self.id)
    all_conversations_with_me = conversation_from_me + conversation_for_me
  end
  

  def has_venmo?
    self.venmo_id && self.encrypted_token
  end

  # def mailboxer_email(object)
  #   email
  # end

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
    self.items.collect{|item| item.offers}.flatten
  end

  def pending_offers_received
    self.offers_received.select{ |offer| offer.status=="pending"}
  end

  def seller?
    !(self.items == [])
  end 

  def buyer?
    !(self.offers_sent == [])
  end 

end
