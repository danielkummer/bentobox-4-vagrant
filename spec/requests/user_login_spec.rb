describe "user sign in" do
  it "allows users to sign in after they have registered" do
    user = User.create(:email    => "someone@example.com",
                       :password => "ilovegrapes",
                       :password_confirmation => "ilovegrapes")

    visit "/users/login"

    fill_in "user_email",    :with => "alindeman@example.com"
    fill_in "user_password", :with => "ilovegrapes"

    click_button "Login"

    page.should have_content("Signed in successfully.")
  end

end
