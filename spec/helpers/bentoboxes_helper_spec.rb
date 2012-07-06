require 'spec_helper'

describe BentoboxesHelper do
  helper BentoboxesHelper
  login_user

  before :all do
    Ingredient.all.delete!
    @bentobox = Fabricate(:bentobox)
  end


  describe "generate vm box name" do
    it "returns a vm box name based on username and vm box name" do
      assign(:bentobox, @bentobox)
      helper.config_vm_box_name.should include('"test@test.com_MyVagrantbox_')
    end
  end

  describe "generate vm box url" do
    it "returns the url to the vm box" do
      assign(:bentobox, @bentobox)
      helper.config_vm_box_url.should include("example.box")
    end
  end

  describe "generate network coonfig" do
    it "returns the network config from a bentobox" do
      assign(:bentobox, @bentobox)
      helper.config_network.should == ':hostonly, "33.33.33.10"'
    end
  end
end


