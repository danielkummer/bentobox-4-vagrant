require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the BentoboxesHelper. For example:
#
# describe BentoboxesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe BentoboxesHelper do


  describe "generate vm box name" do
    it "returns a vm box name based on username and vm box name" do
      current_user = FactoryGirt.create(:user)
      helper.config_vm_box_name.should == "MyVagrantbox"
    end
  end

  describe "generate network coonfig" do
    it "returns the network config from a bentobox" do
      helper.config_network_config(FactoryGirl.create(:bentobox)).should == ':hostonly, "33.33.33.10"'
    end
  end
end
