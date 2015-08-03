class User < ActiveRecord::Base
  belongs_to :community
  has_many :items, :foreign_key => 'seller_id'

  validates :name, presence: true, format: { 
    with: /\A[a-zA-Z]+\z/,
    message: "only allows letters"
  }

  validates :email, presence: true, format: {
    with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
    message: "must be proper email format"
  }
  
  has_secure_password
end
