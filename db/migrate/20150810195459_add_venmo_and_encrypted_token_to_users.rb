class AddVenmoAndEncryptedTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :venmo_id, :string
    add_column :users, :encrypted_token, :string
  end
end
