require "spec_helper"

describe VagrantboxesController do
  describe "routing" do

    it "routes to #index" do
      get("/vagrantboxes").should route_to("vagrantboxes#index")
    end

    it "routes to #new" do
      get("/vagrantboxes/new").should route_to("vagrantboxes#new")
    end

    it "routes to #show" do
      get("/vagrantboxes/1").should route_to("vagrantboxes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/vagrantboxes/1/edit").should route_to("vagrantboxes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/vagrantboxes").should route_to("vagrantboxes#create")
    end

    it "routes to #update" do
      put("/vagrantboxes/1").should route_to("vagrantboxes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/vagrantboxes/1").should route_to("vagrantboxes#destroy", :id => "1")
    end

  end
end
