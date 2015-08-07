class CreateOfferPaymentOptions < ActiveRecord::Migration
  def change
    create_table :offer_payment_options do |t|
      t.integer :offer_id
      t.integer :payment_option_id
      t.timestamps null: false
    end
  end
end
