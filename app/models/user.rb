class User < ActiveRecord::Base
  belongs_to :community
  has_many :items, :foreign_key => 'seller_id'
end
