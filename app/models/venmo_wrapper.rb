class VenmoWrapper

  def initialize
    
  end

  def transfer_money_from(buyer,seller,amount,note)

    if buyer.has_venmo? && seller.has_venmo?
    
      conn = Faraday.new(:url => 'https://api.venmo.com') do |faraday|
             faraday.request  :url_encoded 
             faraday.response :logger
             faraday.adapter  Faraday.default_adapter
             end

      response = conn.post '/v1/payments', { user_id: seller.venmo_id, amount: amount, note: note, access_token: buyer.token}
    end

  end


  def authenticate_venmo(user, auth_hash)
    if auth_hash[:provider] == "venmo"
      user.venmo_id = auth_hash[:uid]
      user.token = auth_hash[:credentials][:token]
      user.save
      redirect_to user_path(user)
    end
  end

end