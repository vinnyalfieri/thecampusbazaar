class VenmoWrapper

  def initialize
    
  end

  def transfer_money_from(buyer,seller,amount,note)

    if buyer.has_venmo? && seller.has_venmo?
    
      conn = Faraday.new(:url => 'https://sandbox-api.venmo.com') do |faraday|
             faraday.request  :url_encoded 
             faraday.response :logger
             faraday.adapter  Faraday.default_adapter
             end

      response = conn.post '/v1/payments', { user_id: seller.venmo_id, amount: amount, note: note, access_token: buyer.token}
      response_json = JSON.parse(response.body)
      #response_json['data']['payment']['status'] => %w(settled pending failed)

      response_json['data']['payment']['status']# == "failed" ? false : true
    end

  end


  def authenticate_venmo(user, auth_hash)
    if auth_hash[:provider] == "venmo"
      user.venmo_id = auth_hash[:uid]
      user.token = auth_hash[:credentials][:token]
      user.save
    end
  end

end