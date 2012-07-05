require 'spec_helper'

describe BentoboxesHelper do
  include Devise::TestHelpers

  before :all do
    assign(:bentobox, Fabricate.build(:bentobox))
    user = Fabricate(:user)
    sign_in user
  end

  describe "generate vm box name" do
    it "returns a vm box name based on username and vm box name" do
      helper.config_vm_box_name.should include('"test@test.com_MyVagrantbox_')
    end
  end

  describe "generate vm box url" do
    it "returns the url to the vm box" do
      helper.config_vm_box_url.should include("example.box")
    end
  end

  describe "generate network coonfig" do
    it "returns the network config from a bentobox" do
      helper.config_network(Fabricate(:bentobox)).should == ':hostonly, "33.33.33.10"'
    end
  end
end


