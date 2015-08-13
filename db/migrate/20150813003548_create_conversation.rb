class CreateConversation < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :seller_id
      t.integer :buyer_id
      t.timestamps null: false
    end
  end
end
