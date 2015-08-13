class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :seller, :class_name => 'User'
  belongs_to :buyer, :class_name => 'User'

  #validates_presence_of :content, :seller_id, :buyer_id
end
