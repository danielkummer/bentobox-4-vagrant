require "spec_helper"

describe AdditionalConfigurationsController do
  describe "routing" do

    it "routes to #index" do
      get("/additional_configurations").should route_to("additional_configurations#index")
    end

    it "routes to #new" do
      get("/additional_configurations/new").should route_to("additional_configurations#new")
    end

    it "routes to #edit" do
      get("/additional_configurations/1/edit").should route_to("additional_configurations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/additional_configurations").should route_to("additional_configurations#create")
    end

    it "routes to #update" do
      put("/additional_configurations/1").should route_to("additional_configurations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/additional_configurations/1").should route_to("additional_configurations#destroy", :id => "1")
    end

  end
end
