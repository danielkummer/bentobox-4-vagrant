require "spec_helper"

describe IngredientsController do
  describe "routing" do

    it "routes to #index" do
      get("/ingredients").should route_to("ingredients#index")
    end

    it "routes to #new" do
      get("/ingredients/new").should route_to("ingredients#new")
    end

    it "routes to #show" do
      get("/ingredients/1").should route_to("ingredients#show", :id => "1")
    end

    it "routes to #edit" do
      get("/ingredients/1/edit").should route_to("ingredients#edit", :id => "1")
    end

    it "routes to #create" do
      post("/ingredients").should route_to("ingredients#create")
    end

    it "routes to #update" do
      put("/ingredients/1").should route_to("ingredients#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/ingredients/1").should route_to("ingredients#destroy", :id => "1")
    end

  end
end
