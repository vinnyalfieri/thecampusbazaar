require 'feature_helper'

describe 'selling an item', type: :feature do 

  include LoginHelper

  before(:each) do
    sign_up_user(@user)
  end

  context 'after logging in' do

    it 'can create a new item on the new item form' do

      click_on "Sell an Item"

      fill_in 'Name', with: "Test Item"
      fill_in 'Price', with: 10
      fill_in 'Description', with: "A cool item"
      select "New", from: "Condition"

      click_on "Add Item"
      expect(page).to have_content("Item created!")
    end

  end

end