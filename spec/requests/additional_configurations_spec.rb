require 'spec_helper'

describe "AdditionalConfigurations" do

  before(:each) { sign_in_as_a_valid_user }

  describe "GET /additional_configurations" do
    it "displays additional configurations" do
      config = Fabricate(:additional_configuration)
      visit additional_configurations_path
      page.should have_content(config.name)
    end

  end
end
