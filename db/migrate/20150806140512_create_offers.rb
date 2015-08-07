class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer :buyer_id
      t.integer :seller_id
      t.integer :item_id 
      t.float :offer_price
      t.string :status 
      t.text :comment
      t.timestamps null: false
    end
  end
end
