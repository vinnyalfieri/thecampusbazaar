module LoginHelper
  def log_in_user(user)
    visit '/'
    click_on 'Log in'
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on 'Submit'
    expect(page).to have_content("Logout")
  end

  def log_out
    click_on "Logout"
    expect(page).to have_content("Login")
  end

  def sign_up_user(user)
    visit '/signup'
    fill_in "Name", with: user.name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password
    click_on "Submit"
    expect(current_path).to eq(root_path)
  end
end