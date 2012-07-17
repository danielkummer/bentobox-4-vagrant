require 'spec_helper'


describe AdditionalConfigurationsController do
  login_user

  def valid_attributes
     {
       name: "MyConfig",
       value: "config.somevalue"
     }
   end
  
  describe "GET index" do
    it "assigns all additional_configurations as @additional_configurations" do
      additional_configuration = Fabricate(:additional_configuration)
      get :index
      assigns(:additional_configurations).should eq([additional_configuration])
    end
  end


  describe "GET new" do
    it "assigns a new additional_configuration as @additional_configuration" do
      get :new
      assigns(:additional_configuration).should be_a_new(AdditionalConfiguration)
    end
  end

  describe "GET edit" do
    it "assigns the requested additional_configuration as @additional_configuration" do
      additional_configuration = Fabricate(:additional_configuration)
      get :edit, {:id => additional_configuration.to_param}
      assigns(:additional_configuration).should eq(additional_configuration)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new AdditionalConfiguration" do
        expect {
          post :create, {:additional_configuration => valid_attributes}
        }.to change(AdditionalConfiguration, :count).by(1)
      end

      it "assigns a newly created additional_configuration as @additional_configuration" do
        post :create, {:additional_configuration => valid_attributes}
        assigns(:additional_configuration).should be_a(AdditionalConfiguration)
        assigns(:additional_configuration).should be_persisted
      end

      it "redirects to the created additional_configuration list" do
        post :create, {:additional_configuration => valid_attributes}
        response.should redirect_to(additional_configurations_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved additional_configuration as @additional_configuration" do
        # Trigger the behavior that occurs when invalid params are submitted
        AdditionalConfiguration.any_instance.stub(:save).and_return(false)
        post :create, {:additional_configuration => {}}
        assigns(:additional_configuration).should be_a_new(AdditionalConfiguration)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        AdditionalConfiguration.any_instance.stub(:save).and_return(false)
        post :create, {:additional_configuration => {}}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested additional_configuration" do
        additional_configuration = Fabricate(:additional_configuration)
        AdditionalConfiguration.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => additional_configuration.to_param, :additional_configuration => {'these' => 'params'}}
      end

      it "assigns the requested additional_configuration as @additional_configuration" do
        additional_configuration = Fabricate(:additional_configuration)
        put :update, {:id => additional_configuration.to_param, :additional_configuration => valid_attributes}
        assigns(:additional_configuration).should eq(additional_configuration)
      end

      it "redirects to the additional_configurations nidex" do
        additional_configuration = Fabricate(:additional_configuration)
        put :update, {:id => additional_configuration.to_param, :additional_configuration => valid_attributes}
        response.should redirect_to(additional_configurations_url)
      end
    end

    describe "with invalid params" do
      it "assigns the additional_configuration as @additional_configuration" do
        additional_configuration = Fabricate(:additional_configuration)
        AdditionalConfiguration.any_instance.stub(:save).and_return(false)
        put :update, {:id => additional_configuration.to_param, :additional_configuration => {}}
        assigns(:additional_configuration).should eq(additional_configuration)
      end

      it "re-renders the 'edit' template" do
        additional_configuration = Fabricate(:additional_configuration)
        AdditionalConfiguration.any_instance.stub(:save).and_return(false)
        put :update, {:id => additional_configuration.to_param, :additional_configuration => {}}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested additional_configuration" do
      additional_configuration = Fabricate(:additional_configuration)
      expect {
        delete :destroy, {:id => additional_configuration.to_param}
      }.to change(AdditionalConfiguration, :count).by(-1)
    end

    it "redirects to the additional_configurations list" do
      additional_configuration = Fabricate(:additional_configuration)
      delete :destroy, {:id => additional_configuration.to_param}
      response.should redirect_to(additional_configurations_url)
    end
  end

end
