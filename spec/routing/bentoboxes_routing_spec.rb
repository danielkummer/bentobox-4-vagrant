require "spec_helper"

describe BentoboxesController do
  describe "routing" do

    it "routes to #index" do
      get("/bentoboxes").should route_to("bentoboxes#index")
    end

    it "routes to #new" do
      get("/bentoboxes/new").should route_to("bentoboxes#new")
    end

    it "routes to #show" do
      get("/bentoboxes/1").should route_to("bentoboxes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/bentoboxes/1/edit").should route_to("bentoboxes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/bentoboxes").should route_to("bentoboxes#create")
    end

    it "routes to #update" do
      put("/bentoboxes/1").should route_to("bentoboxes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/bentoboxes/1").should route_to("bentoboxes#destroy", :id => "1")
    end

  end
end
