require "spec_helper"

describe BentoboxesController do
  describe "routing" do

    it "routes to #index" do
      get("/bentoboxes").should route_to("bentoboxes#index")
    end

    it "routes to #show" do
      get("/bentoboxes/1").should route_to("bentoboxes#show", :id => "1")
    end

    it "routes to #new" do
      get("/users/1/bentoboxes/new").should route_to("bentoboxes#new", :user_id => "1")
    end

    it "routes to #edit" do
      get("/users/1/bentoboxes/1/edit").should route_to("bentoboxes#edit", :id => "1", :user_id => "1")
    end

    it "routes to #create" do
      post("/users/1/bentoboxes").should route_to("bentoboxes#create", :user_id => "1")
    end

    it "routes to #update" do
      put("/users/1/bentoboxes/1").should route_to("bentoboxes#update", :id => "1",  :user_id => "1")
    end

    it "routes to #destroy" do
      delete("/users/1/bentoboxes/1").should route_to("bentoboxes#destroy", :id => "1", :user_id => "1")
    end

  end
end
