require "spec_helper"

describe AppConfigurationsController do
  describe "routing" do

    it "routes to #index" do
      get("/app_configurations").should route_to("app_configurations#index")
    end

    it "routes to #new" do
      get("/app_configurations/new").should route_to("app_configurations#new")
    end

    it "routes to #show" do
      get("/app_configurations/1").should route_to("app_configurations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/app_configurations/1/edit").should route_to("app_configurations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/app_configurations").should route_to("app_configurations#create")
    end

    it "routes to #update" do
      put("/app_configurations/1").should route_to("app_configurations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/app_configurations/1").should route_to("app_configurations#destroy", :id => "1")
    end

  end
end
