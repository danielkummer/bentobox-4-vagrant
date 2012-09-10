require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe AppConfigurationsController do

  # This should return the minimal set of attributes required to create a valid
  # AppConfiguration. As you add validations to AppConfiguration, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AppConfigurationsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all app_configurations as @app_configurations" do
      app_configuration = AppConfiguration.create! valid_attributes
      get :index, {}, valid_session
      assigns(:app_configurations).should eq([app_configuration])
    end
  end

  describe "GET show" do
    it "assigns the requested app_configuration as @app_configuration" do
      app_configuration = AppConfiguration.create! valid_attributes
      get :show, {:id => app_configuration.to_param}, valid_session
      assigns(:app_configuration).should eq(app_configuration)
    end
  end

  describe "GET new" do
    it "assigns a new app_configuration as @app_configuration" do
      get :new, {}, valid_session
      assigns(:app_configuration).should be_a_new(AppConfiguration)
    end
  end

  describe "GET edit" do
    it "assigns the requested app_configuration as @app_configuration" do
      app_configuration = AppConfiguration.create! valid_attributes
      get :edit, {:id => app_configuration.to_param}, valid_session
      assigns(:app_configuration).should eq(app_configuration)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new AppConfiguration" do
        expect {
          post :create, {:app_configuration => valid_attributes}, valid_session
        }.to change(AppConfiguration, :count).by(1)
      end

      it "assigns a newly created app_configuration as @app_configuration" do
        post :create, {:app_configuration => valid_attributes}, valid_session
        assigns(:app_configuration).should be_a(AppConfiguration)
        assigns(:app_configuration).should be_persisted
      end

      it "redirects to the created app_configuration" do
        post :create, {:app_configuration => valid_attributes}, valid_session
        response.should redirect_to(AppConfiguration.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved app_configuration as @app_configuration" do
        # Trigger the behavior that occurs when invalid params are submitted
        AppConfiguration.any_instance.stub(:save).and_return(false)
        post :create, {:app_configuration => {}}, valid_session
        assigns(:app_configuration).should be_a_new(AppConfiguration)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        AppConfiguration.any_instance.stub(:save).and_return(false)
        post :create, {:app_configuration => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested app_configuration" do
        app_configuration = AppConfiguration.create! valid_attributes
        # Assuming there are no other app_configurations in the database, this
        # specifies that the AppConfiguration created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        AppConfiguration.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => app_configuration.to_param, :app_configuration => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested app_configuration as @app_configuration" do
        app_configuration = AppConfiguration.create! valid_attributes
        put :update, {:id => app_configuration.to_param, :app_configuration => valid_attributes}, valid_session
        assigns(:app_configuration).should eq(app_configuration)
      end

      it "redirects to the app_configuration" do
        app_configuration = AppConfiguration.create! valid_attributes
        put :update, {:id => app_configuration.to_param, :app_configuration => valid_attributes}, valid_session
        response.should redirect_to(app_configuration)
      end
    end

    describe "with invalid params" do
      it "assigns the app_configuration as @app_configuration" do
        app_configuration = AppConfiguration.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        AppConfiguration.any_instance.stub(:save).and_return(false)
        put :update, {:id => app_configuration.to_param, :app_configuration => {}}, valid_session
        assigns(:app_configuration).should eq(app_configuration)
      end

      it "re-renders the 'edit' template" do
        app_configuration = AppConfiguration.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        AppConfiguration.any_instance.stub(:save).and_return(false)
        put :update, {:id => app_configuration.to_param, :app_configuration => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested app_configuration" do
      app_configuration = AppConfiguration.create! valid_attributes
      expect {
        delete :destroy, {:id => app_configuration.to_param}, valid_session
      }.to change(AppConfiguration, :count).by(-1)
    end

    it "redirects to the app_configurations list" do
      app_configuration = AppConfiguration.create! valid_attributes
      delete :destroy, {:id => app_configuration.to_param}, valid_session
      response.should redirect_to(app_configurations_url)
    end
  end

end
