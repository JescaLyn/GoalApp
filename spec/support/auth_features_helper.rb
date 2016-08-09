module AuthFeaturesHelper
  def register_as(username)
    visit new_user_url
    fill_in "Username", with: username
    fill_in "Password", with: "password"
    click_button "Create User"
  end

  def login_as(username)
    visit new_session_url
    fill_in "Username", with: username
    fill_in "Password", with: "password"
    click_button "Login"
  end
end
