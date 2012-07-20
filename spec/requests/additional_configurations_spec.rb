require 'spec_helper'

describe "AdditionalConfigurations" do

  before(:each) { login_with :user }

  describe "GET /additional_configurations" do
    it "displays additional configurations" do
      config = Fabricate(:additional_configuration)
      visit additional_configurations_path
      page.should have_content(config.name)
    end

  end
end
