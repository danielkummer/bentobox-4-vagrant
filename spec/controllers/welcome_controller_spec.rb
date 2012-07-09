require 'spec_helper'

describe WelcomeController do
  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
      out response.inspect
    end
  end
end

