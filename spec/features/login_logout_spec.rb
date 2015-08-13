require 'feature_helper'

describe 'login/logout', type: :feature do

  include LoginHelper

  context 'logging in' do

    it 'is successful' do
      log_in_successfully
    end

  end

  context 'logging out' do 

    it 'is successful' do
      log_in_successfully
      click_on "Logout"
      expect(page).to have_content("Login")
    end

  end

end