class AddItemIdToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :item_id, :integer
  end
end
