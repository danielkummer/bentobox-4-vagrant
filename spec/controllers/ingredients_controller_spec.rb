require 'spec_helper'


describe IngredientsController do
  login_user

  def valid_attributes
    {name: "testingredient"}
  end
  
  describe "GET index" do
    it "assigns all ingredients as @ingredients" do
      ingredient = Fabricate(:ingredient)
      get :index
      assigns(:ingredients).should eq([ingredient])
    end
  end

  describe "GET show" do
    it "assigns the requested ingredient as @ingredient" do
      ingredient = Fabricate(:ingredient)
      get :show, {:id => ingredient.to_param}
      assigns(:ingredient).should eq(ingredient)
    end
  end

  describe "GET new" do
    it "assigns a new ingredient as @ingredient" do
      get :new
      assigns(:ingredient).should be_a_new(Ingredient)
    end
  end

  describe "GET edit" do
    it "assigns the requested ingredient as @ingredient" do
      ingredient = Fabricate(:ingredient)
      get :edit, {:id => ingredient.to_param}
      assigns(:ingredient).should eq(ingredient)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Ingredient" do
        expect {
          post :create, {:ingredient => valid_attributes}
        }.to change(Ingredient, :count).by(1)
      end

      it "assigns a newly created ingredient as @ingredient" do
        post :create, {:ingredient => valid_attributes}
        assigns(:ingredient).should be_a(Ingredient)
        assigns(:ingredient).should be_persisted
      end

      it "redirects to the created ingredient" do
        post :create, {:ingredient => valid_attributes}
        response.should render_template("index")
        response.should render_template("index")
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved ingredient as @ingredient" do
        # Trigger the behavior that occurs when invalid params are submitted
        Ingredient.any_instance.stub(:save).and_return(false)
        post :create, {:ingredient => {}}
        assigns(:ingredient).should be_a_new(Ingredient)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Ingredient.any_instance.stub(:save).and_return(false)
        post :create, {:ingredient => {}}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested ingredient" do
        ingredient = Fabricate(:ingredient)
        # Assuming there are no other ingredients in the database, this
        # specifies that the Ingredient created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Ingredient.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => ingredient.to_param, :ingredient => {'these' => 'params'}}
      end

      it "assigns the requested ingredient as @ingredient" do
        ingredient = Fabricate(:ingredient)
        put :update, {:id => ingredient.to_param, :ingredient => valid_attributes}
        assigns(:ingredient).should eq(ingredient)
      end

      it "redirects to the ingredient" do
        ingredient = Fabricate(:ingredient)
        put :update, {:id => ingredient.to_param, :ingredient => valid_attributes}
        response.should redirect_to(ingredient)
      end
    end

    describe "with invalid params" do
      it "assigns the ingredient as @ingredient" do
        ingredient = Fabricate(:ingredient)
        # Trigger the behavior that occurs when invalid params are submitted
        Ingredient.any_instance.stub(:save).and_return(false)
        put :update, {:id => ingredient.to_param, :ingredient => {}}
        assigns(:ingredient).should eq(ingredient)
      end

      it "re-renders the 'edit' template" do
        ingredient = Fabricate(:ingredient)
        # Trigger the behavior that occurs when invalid params are submitted
        Ingredient.any_instance.stub(:save).and_return(false)
        put :update, {:id => ingredient.to_param, :ingredient => {}}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested ingredient" do
      ingredient = Fabricate(:ingredient)
      expect {
        delete :destroy, {:id => ingredient.to_param}
      }.to change(Ingredient, :count).by(-1)
    end

    it "redirects to the ingredients list" do
      ingredient = Fabricate(:ingredient)
      delete :destroy, {:id => ingredient.to_param}
      response.should redirect_to(ingredients_url)
    end
  end

end
