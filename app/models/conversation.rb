class Conversation < ActiveRecord::Base
  belongs_to :item 
  belongs_to :user1, :foreign_key => :user1_id, :class_name => 'User'
  belongs_to :user2,:foreign_key => :user2_id, :class_name => 'User'
  has_many :messages

#self is the conversation itself, from the message form @conversation
  def recipient(current_user)
    if (current_user.id == self.user1_id)
      self.user2_id 
    else (current_user.id == self.user2_id)
      self.user1_id
    end
  end
end


