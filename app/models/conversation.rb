class Conversation < ActiveRecord::Base
  belongs_to :item 
  belongs_to :user1, :foreign_key => :user1_id, :class_name => 'User'
  belongs_to :user2,:foreign_key => :user2_id, :class_name => 'User'
  has_many :messages

end


