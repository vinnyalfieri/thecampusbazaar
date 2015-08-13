module LoginHelper
  def log_in_successfully
    visit '/'
    click_on 'Log in'
    fill_in "Email", with: "jfaris@conncoll.edu"
    fill_in "Password", with: "abc"
    click_on 'Submit'
    expect(page).to have_content("Logout")
  end
end