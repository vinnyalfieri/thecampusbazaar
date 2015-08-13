require 'feature_helper'

describe 'login/logout', type: :feature do

  include LoginHelper

  before do 
    sign_up_user(@user)
    log_out
  end

  context 'logging in' do

    it 'is successful' do
      log_in_user(@user)
    end

  end

  context 'logging out' do 

    it 'is successful' do
      log_in_user(@user)
      log_out
    end

  end

end