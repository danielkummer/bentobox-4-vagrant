require 'spec_helper'


describe BentoboxesController do
  login_user

  def valid_attributes
    {}
  end



  describe "GET index" do
    it "assigns all bentoboxes as @bentoboxes" do
      bentobox = Fabricate(:bentobox)
      get :index
      assigns(:bentoboxes).should eq([bentobox])
    end
  end

  describe "GET show" do
    it "assigns the requested bentobox as @bentobox" do
      bentobox = Fabricate(:bentobox)
      get :show, {:id => bentobox.to_param}
      assigns(:bentobox).should eq(bentobox)
    end
  end

  describe "GET new" do
    it "assigns a new bentobox as @bentobox" do
      get :new
      assigns(:bentobox).should be_a_new(Bentobox)
    end
  end

  describe "GET edit" do
    it "assigns the requested bentobox as @bentobox" do
      bentobox = Fabricate(:bentobox)
      get :edit, {:id => bentobox.to_param}
      assigns(:bentobox).should eq(bentobox)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Bentobox" do
        expect {
          post :create, {:bentobox => Fabricate(:bentobox)}
        }.to change(Bentobox, :count).by(1)
      end

      it "assigns a newly created bentobox as @bentobox" do
        post :create, {:bentobox => Fabricate(:bentobox)}
        assigns(:bentobox).should be_a(Bentobox)
        assigns(:bentobox).should be_persisted
      end

      it "redirects to the created bentobox" do
        post :create, {:bentobox => Fabricate(:bentobox)}
        response.should redirect_to(Bentobox.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved bentobox as @bentobox" do
        # Trigger the behavior that occurs when invalid params are submitted
        Bentobox.any_instance.stub(:save).and_return(false)
        post :create, {:bentobox => {}}
        assigns(:bentobox).should be_a_new(Bentobox)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Bentobox.any_instance.stub(:save).and_return(false)
        post :create, {:bentobox => {}}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested bentobox" do
        bentobox = Fabricate(:bentobox)
        # Assuming there are no other bentoboxes in the database, this
        # specifies that the Bentobox created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Bentobox.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => bentobox.to_param, :bentobox => {'these' => 'params'}}
      end

      it "assigns the requested bentobox as @bentobox" do
        bentobox = Fabricate(:bentobox)
        put :update, {:id => bentobox.to_param, :bentobox => valid_attributes}
        assigns(:bentobox).should eq(bentobox)
      end

      it "redirects to the bentobox" do
        bentobox = Fabricate(:bentobox)
        put :update, {:id => bentobox.to_param, :bentobox => valid_attributes}
        response.should redirect_to(bentobox)
      end
    end

    describe "with invalid params" do
      it "assigns the bentobox as @bentobox" do
        bentobox = Fabricate(:bentobox)
        # Trigger the behavior that occurs when invalid params are submitted
        Bentobox.any_instance.stub(:save).and_return(false)
        put :update, {:id => bentobox.to_param, :bentobox => {}}
        assigns(:bentobox).should eq(bentobox)
      end

      it "re-renders the 'edit' template" do
        bentobox = Fabricate(:bentobox)
        # Trigger the behavior that occurs when invalid params are submitted
        Bentobox.any_instance.stub(:save).and_return(false)
        put :update, {:id => bentobox.to_param, :bentobox => {}}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested bentobox" do
      bentobox = Fabricate(:bentobox)
      expect {
        delete :destroy, {:id => bentobox.to_param}
      }.to change(Bentobox, :count).by(-1)
    end

    it "redirects to the bentoboxes list" do
      bentobox = Fabricate(:bentobox)
      delete :destroy, {:id => bentobox.to_param}
      response.should redirect_to(bentoboxes_url)
    end
  end

end
