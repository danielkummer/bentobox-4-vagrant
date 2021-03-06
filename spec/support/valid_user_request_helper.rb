include Warden::Test::Helpers
# module for helping request specs
module ValidUserRequestHelper
  # for use in request specs
  def sign_in_as_a_valid_user
    @user ||= Fabricate :user
    post user_session_path, 'users[email]' => @user.email, 'users[password]' => @user.password
  end

  def logout_user(user = @current_user)
    Capybara.reset_sessions!
    visit destroy_user_session_url
  end

  def login_with(sym)
    logout_user if @current_user
    @current_user = Fabricate sym.to_sym
    visit new_user_session_url
    fill_in "user_email", :with => @current_user.email
    fill_in "user_password", :with => @current_user.password
    click_button "Login"
  end

  #not working
=begin
  def create_logged_in_user
    user = Factory(:user)
    login(user)
    user
  end


  def login(user)
    login_as user, scope: :user
  end
=end
end