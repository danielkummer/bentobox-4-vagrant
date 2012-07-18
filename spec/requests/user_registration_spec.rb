require "spec_helper"

describe "users registration" do

  it "allows new users to register with an email address and password" do
    visit "/users/register"

    within '#new_user' do
      fill_in "Email",                 :with => "alindeman@example.com"
      fill_in "Password",              :with => "ilovegrapes"
      fill_in "Password confirmation", :with => "ilovegrapes"

      click_button "Sign up"
    end


    page.should have_content("Welcome! You have signed up successfully.")
  end
end