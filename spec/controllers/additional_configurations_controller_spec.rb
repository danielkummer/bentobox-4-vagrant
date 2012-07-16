require 'spec_helper'


describe AdditionalConfigurationsController do

  # This should return the minimal set of attributes required to create a valid
  # AdditionalConfiguration. As you add validations to AdditionalConfiguration, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AdditionalConfigurationsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all additional_configurations as @additional_configurations" do
      additional_configuration = AdditionalConfiguration.create! valid_attributes
      get :index, {}, valid_session
      assigns(:additional_configurations).should eq([additional_configuration])
    end
  end


  describe "GET new" do
    it "assigns a new additional_configuration as @additional_configuration" do
      get :new, {}, valid_session
      assigns(:additional_configuration).should be_a_new(AdditionalConfiguration)
    end
  end

  describe "GET edit" do
    it "assigns the requested additional_configuration as @additional_configuration" do
      additional_configuration = AdditionalConfiguration.create! valid_attributes
      get :edit, {:id => additional_configuration.to_param}, valid_session
      assigns(:additional_configuration).should eq(additional_configuration)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new AdditionalConfiguration" do
        expect {
          post :create, {:additional_configuration => valid_attributes}, valid_session
        }.to change(AdditionalConfiguration, :count).by(1)
      end

      it "assigns a newly created additional_configuration as @additional_configuration" do
        post :create, {:additional_configuration => valid_attributes}, valid_session
        assigns(:additional_configuration).should be_a(AdditionalConfiguration)
        assigns(:additional_configuration).should be_persisted
      end

      it "redirects to the created additional_configuration" do
        post :create, {:additional_configuration => valid_attributes}, valid_session
        response.should redirect_to(AdditionalConfiguration.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved additional_configuration as @additional_configuration" do
        # Trigger the behavior that occurs when invalid params are submitted
        AdditionalConfiguration.any_instance.stub(:save).and_return(false)
        post :create, {:additional_configuration => {}}, valid_session
        assigns(:additional_configuration).should be_a_new(AdditionalConfiguration)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        AdditionalConfiguration.any_instance.stub(:save).and_return(false)
        post :create, {:additional_configuration => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested additional_configuration" do
        additional_configuration = AdditionalConfiguration.create! valid_attributes
        # Assuming there are no other additional_configurations in the database, this
        # specifies that the AdditionalConfiguration created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        AdditionalConfiguration.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => additional_configuration.to_param, :additional_configuration => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested additional_configuration as @additional_configuration" do
        additional_configuration = AdditionalConfiguration.create! valid_attributes
        put :update, {:id => additional_configuration.to_param, :additional_configuration => valid_attributes}, valid_session
        assigns(:additional_configuration).should eq(additional_configuration)
      end

      it "redirects to the additional_configuration" do
        additional_configuration = AdditionalConfiguration.create! valid_attributes
        put :update, {:id => additional_configuration.to_param, :additional_configuration => valid_attributes}, valid_session
        response.should redirect_to(additional_configuration)
      end
    end

    describe "with invalid params" do
      it "assigns the additional_configuration as @additional_configuration" do
        additional_configuration = AdditionalConfiguration.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        AdditionalConfiguration.any_instance.stub(:save).and_return(false)
        put :update, {:id => additional_configuration.to_param, :additional_configuration => {}}, valid_session
        assigns(:additional_configuration).should eq(additional_configuration)
      end

      it "re-renders the 'edit' template" do
        additional_configuration = AdditionalConfiguration.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        AdditionalConfiguration.any_instance.stub(:save).and_return(false)
        put :update, {:id => additional_configuration.to_param, :additional_configuration => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested additional_configuration" do
      additional_configuration = AdditionalConfiguration.create! valid_attributes
      expect {
        delete :destroy, {:id => additional_configuration.to_param}, valid_session
      }.to change(AdditionalConfiguration, :count).by(-1)
    end

    it "redirects to the additional_configurations list" do
      additional_configuration = AdditionalConfiguration.create! valid_attributes
      delete :destroy, {:id => additional_configuration.to_param}, valid_session
      response.should redirect_to(additional_configurations_url)
    end
  end

end
