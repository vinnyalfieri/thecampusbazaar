require 'feature_helper'

describe 'signing up', type: :feature do

  before(:each) do
    visit '/'
    click_on "Signup"
  end

  context 'a valid user' do


    context 'without a community (.edu) email' do

      it 'signs up successfully & redirects to community search path' do
        # binding.pry
        fill_in "Name", with: "Jake Faris"
        fill_in "Email", with: "jfaris@conncoll.edu"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "password"
        click_on "Submit"
        expect(current_path).to eq(root_path)
      end

    end

    context 'with a community (.edu) email' do

      it 'signs up successfully & redirects to community search path' do
        fill_in "Name", with: "Jake Faris"
        fill_in "Email", with: "jake.faris@flatironschool.com"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "password"
        click_on "Submit"
        expect(current_path).to eq(search_path)
      end

    end

  end

  context 'an invalid user' do 

    context 'without a name' do
      it 'does not sign up successfully and redirects back to signup page with errors' do
        fill_in "Email", with: "jake.faris@flatironschool.com"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "password"
        click_on "Submit"
        expect(page).to have_content('error')
      end
    end

    context 'with an invalid email' do 
      it 'does not sign up successfully and redirects back to signup page with errors' do
        fill_in "Name", with: "Jake Faris"
        fill_in "Email", with: "jake.faris"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "password"
        click_on "Submit"
        expect(page).to have_content('error')
      end
    end

    context 'with a mismatched password' do
      it 'does not sign up successfully and redirects back to signup page with errors' do
        fill_in "Name", with: "Jake Faris"
        fill_in "Email", with: "jake.faris@flatironschool.com"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "blahblahblah"
        click_on "Submit"
        expect(page).to have_content('error')
      end
    end

  end

end