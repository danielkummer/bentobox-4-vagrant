require 'spec_helper'


describe VagrantboxesController do
  login_user

  def valid_attributes
    {}
  end
   
  describe "GET index" do
    it "assigns all vagrantboxes as @vagrantboxes" do
      vagrantbox = Fabricate(:vagrantbox)
      get :index
      assigns(:vagrantboxes).should eq([vagrantbox])
    end
  end

  describe "GET new" do
    it "assigns a new vagrantbox as @vagrantbox" do
      get :new
      assigns(:vagrantbox).should be_a_new(Vagrantbox)
    end
  end

  describe "GET edit" do
    it "assigns the requested vagrantbox as @vagrantbox" do
      vagrantbox = Fabricate(:vagrantbox)
      get :edit, {:id => vagrantbox.to_param}
      assigns(:vagrantbox).should eq(vagrantbox)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Vagrantbox" do
        expect {
          post :create, {:vagrantbox => Fabricate.build(:vagrantbox)}
        }.to change(Vagrantbox, :count).by(1)
      end


      it "assigns a newly created vagrantbox as @vagrantbox" do
        post :create, {:vagrantbox => Fabricate.build(:vagrantbox)}
        assigns(:vagrantbox).should be_a(Vagrantbox)
        assigns(:vagrantbox).should be_persisted
      end

      it "redirects to the created vagrantbox" do
        post :create, {:vagrantbox => Fabricate.build(:vagrantbox)}
        response.should be_success
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved vagrantbox as @vagrantbox" do
        Vagrantbox.any_instance.stub(:save).and_return(false)
        post :create, {:vagrantbox => {}}
        assigns(:vagrantbox).should be_a_new(Vagrantbox)
      end

      it "re-renders the 'new' template" do
        Vagrantbox.any_instance.stub(:save).and_return(false)
        post :create, {:vagrantbox => {}}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested vagrantbox" do
        vagrantbox = Fabricate(:vagrantbox)
        Vagrantbox.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => vagrantbox.to_param, :vagrantbox => {'these' => 'params'}}
      end

      it "assigns the requested vagrantbox as @vagrantbox" do
        vagrantbox = Fabricate(:vagrantbox)
        put :update, {:id => vagrantbox.to_param, :vagrantbox => valid_attributes}
        assigns(:vagrantbox).should eq(vagrantbox)
      end

      it "redirects to the vagrantbox" do
        vagrantbox = Fabricate(:vagrantbox)
        put :update, {:id => vagrantbox.to_param, :vagrantbox => valid_attributes}
        response.should redirect_to(vagrantbox)
      end
    end

    describe "with invalid params" do
      it "assigns the vagrantbox as @vagrantbox" do
        vagrantbox = Fabricate(:vagrantbox)
        Vagrantbox.any_instance.stub(:save).and_return(false)
        put :update, {:id => vagrantbox.to_param, :vagrantbox => {}}
        assigns(:vagrantbox).should eq(vagrantbox)
      end

      it "re-renders the 'edit' template" do
        vagrantbox = Fabricate(:vagrantbox)
        Vagrantbox.any_instance.stub(:save).and_return(false)
        put :update, {:id => vagrantbox.to_param, :vagrantbox => {}}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested vagrantbox" do
      vagrantbox = Fabricate(:vagrantbox)
      expect {
        delete :destroy, {:id => vagrantbox.to_param}
      }.to change(Vagrantbox, :count).by(-1)
    end

    it "redirects to the vagrantboxes list" do
      vagrantbox = Fabricate(:vagrantbox)
      delete :destroy, {:id => vagrantbox.to_param}
      response.should redirect_to(vagrantboxes_url)
    end
  end

end
