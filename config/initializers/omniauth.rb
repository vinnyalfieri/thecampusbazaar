Rails.application.config.middleware.use OmniAuth::Builder do
    provider :venmo, ENV['venmo_client_id'], ENV['venmo_secret'], scope: "access_profile,make_payments", response_type: "code"
end