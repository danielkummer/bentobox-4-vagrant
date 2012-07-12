require 'spec_helper'

describe "Categories" do
  before(:each) { login_with :user }
  describe "GET /categories" do
    it "displays categories" do
      category = Fabricate(:category)
      visit categories_path
      page.should have_content(category.name)
    end
  end
end