class User < ActiveRecord::Base
  belongs_to :community
  has_many :items, :foreign_key => 'seller_id'

  validates :name, presence: true, format: { 
    with: /[a-zA-Z\s]/,
    message: "only allows letters and spaces"
  }

  validates :email, presence: true, format: {
    with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
    message: "must be proper email format"
  }
  
  has_secure_password
end
