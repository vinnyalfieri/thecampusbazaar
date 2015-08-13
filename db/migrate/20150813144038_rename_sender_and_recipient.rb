class RenameSenderAndRecipient < ActiveRecord::Migration
  def change
    rename_column :conversations, :recipient_id, :user2_id
    rename_column :conversations, :sender_id, :user1_id
  end
end
