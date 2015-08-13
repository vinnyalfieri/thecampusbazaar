class CreateMessage < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :seller_id
      t.integer :buyer_id
      t.integer :conversation_id
      t.text :content
      t.boolean :read, :default => false
      t.timestamps null: false
    end
  end
end
