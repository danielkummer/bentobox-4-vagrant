require 'spec_helper'


describe ChefClient do

  before :each do
    APP_CONFIG[:cookbooks] ||= "apache2, mysql, third"
  end

  it "should bypass the chef server" do
    ChefClient.send(:bypass_chef_server?).should be_true
  end

  it "should get the cookbooks list specified in app_config.yml" do
    ChefClient.cookbooks_list.should eq({'apache2' => 'apache2', 'mysql' => 'mysql', 'third' => 'third'})
  end

  it "should throw an exception when trying to connecto to a chef server" do
    APP_CONFIG[:chef_server_url] = nil
    APP_CONFIG[:cookbooks] = nil

    expect {
      ChefClient.cookbooks_list
    }.to raise_exception Exception
  end

  it "should return an api object of type chef rest" do
    ChefClient.rest.should be_kind_of(Chef::REST)
  end


end