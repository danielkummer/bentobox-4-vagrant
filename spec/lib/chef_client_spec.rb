require 'spec_helper'


describe ChefClient do

  it "should get the cookbooks list specified in app_config.yml" do
    ChefClient.cookbooks_list.should eq(['apache2', 'mysql', 'third'])


  end
end