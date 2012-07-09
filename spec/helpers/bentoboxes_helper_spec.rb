require 'spec_helper'

describe BentoboxesHelper do
  helper BentoboxesHelper
  login_user

  before(:each) do
    @bentobox = Fabricate(:bentobox)
  end


  it "returns a vm box name based on username and vm box name" do
    assign(:bentobox, @bentobox)
    helper.config_vm_box_name.should include(@bentobox.name)
  end


  it "returns the url to the vm box" do
    assign(:bentobox, @bentobox)
    helper.config_vm_box_url.should include("example.box")
  end


  it "returns the network config from a bentobox" do
    bentobox = Fabricate(:bentobox_with_ingredient)

    assign(:bentobox, bentobox)
    helper.config_network.should == ':hostonly, "33.33.33.10"'
  end

end


