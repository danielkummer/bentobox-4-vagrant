include Warden::Test::Helpers


describe "user sign in" do

=begin
 #sadly not working...

  before :each do
    Warden.test_mode!
    @user = User.create!(:email => "someone@example.com",
                         :password => "ilovegrapes",
                         :password_confirmation => "ilovegrapes")
    @user.save!
    Capybara.reset_sessions!
  end

  after :each do
    Warden.test_reset!
  end


  it "allows users to sign in after they have registered" do
    visit "/users/login"

    page.should have_content('Login')

    within '#new_user' do
      fill_in "user_email", :with => "alindeman@example.com"
      fill_in "user_password", :with => "ilovegrapes"

      click_button "Login"

    end

    page.should have_content("Signed in successfully.")
  end
=end
end
