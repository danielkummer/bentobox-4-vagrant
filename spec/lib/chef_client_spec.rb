require 'spec_helper'


describe ChefClientApi do

  describe "configuration" do
    it "should throw an exception when trying to connecto to a chef server" do
      APP_CONFIG[:chef_server_api_url] = nil
      APP_CONFIG[:cookbooks] = nil

      expect {
        ChefClientApi.cookbooks_list
      }.to raise_exception Exception
    end

    it "should return an api object of type chef rest" do
      ChefClientApi.rest.should be_kind_of(Chef::REST)
    end
  end


  describe "api" do
    before :each do
      @user = Fabricate(:user)
    end


    it "should return success on a succesful connection" do
      stub_request(:get, "http://localhost:4000/clients/#{APP_CONFIG[:chef_node_name]}").to_return(body: {}.to_json, headers: {'Content-Type' => 'application/json'}, status: 200)
      result = ChefClientApi.connected?
      result.should be_true
      a_request(:get, "http://localhost:4000/clients/#{APP_CONFIG[:chef_node_name]}").should have_been_made
    end

    it "should get an existing client" do
      stub_request(:get, "http://localhost:4000/clients/#{@user.client_name}").to_return(status: 200, body: { name: @user.client_name, admin: false, }.to_json, headers: {'Content-Type' => 'application/json'})

      result = ChefClientApi.get_client(@user)
      result.has_key?('name').should be_true
      result.has_key?('admin').should be_true
      result['name'].should eq(@user.client_name)
      result['admin'].should eq(false)

      a_request(:get, "http://localhost:4000/clients/#{@user.client_name}").should have_been_made
    end

  end


  #getclient
  #createclient
  #deleteclient
  #cookbooks list


end