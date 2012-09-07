require 'spec_helper'

describe "Categories" do
  before(:each) { sign_in_as_a_valid_user }

  describe "GET /categories" do
    it "displays categories" do
      category = Fabricate(:category)
      visit categories_path
      page.should have_content(category.name)
    end
  end
end
