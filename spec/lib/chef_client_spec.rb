require 'spec_helper'



=begin
ebMock.should have_requested(:get, "www.example.com").with(:body => "abc", :headers => {'Content-Length' => 3}).twice

WebMock.should_not have_requested(:get, "www.something.com")

WebMock.should have_requested(:post, "www.example.com").with { |req| req.body == "abc" }

WebMock.should have_requested(:get, "www.example.com").with(:query => {"a" => ["b", "c"]})

WebMock.should have_requested(:get, "www.example.com").with(:query => hash_including({"a" => ["b", "c"]}))

WebMock.should have_requested(:get, "www.example.com").
  with(:body => {"a" => ["b", "c"]}, :headers => {'Content-Type' => 'application/json'})


a_request(:post, "www.example.com").with(:body => "abc", :headers => {'Content-Length' => 3}).should have_been_made.once

a_request(:post, "www.something.com").should have_been_made.times(3)

a_request(:any, "www.example.com").should_not have_been_made

a_request(:post, "www.example.com").with { |req| req.body == "abc" }.should have_been_made

a_request(:get, "www.example.com").with(:query => {"a" => ["b", "c"]}).should have_been_made

a_request(:get, "www.example.com").with(:query => hash_including({"a" => ["b", "c"]})).should have_been_made

a_request(:post, "www.example.com").
  with(:body => {"a" => ["b", "c"]}, :headers => {'Content-Type' => 'application/json'}).should have_been_made

=end

describe ChefClientApi do

  it "should return success on a succesful connection" do
    stub_request(:get, /#{APP_CONFIG[:chef_server_api_url]}\/clients\/#{APP_CONFIG[:chef_node_name]}\/.*/).to_return(:body => "all ok....")
    ChefClientApi.connected?.should be_true
    a_request(:get, /#{APP_CONFIG[:chef_server_api_url]}\/clients\/#{APP_CONFIG[:chef_node_name]}\/.*/).should have_been_made

  end

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