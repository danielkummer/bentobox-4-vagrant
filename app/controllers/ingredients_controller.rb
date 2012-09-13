class IngredientsController < ApplicationController
  respond_to :html

  before_filter :get_available_cookbooks, :only => [:new, :edit]

  def initialize
    super()
    @network = [:hostonly, :bridged]
  end

  def index
    @ingredients = Ingredient.all
    respond_with @ingredients
  end

  def show
    @ingredient = Ingredient.find(params[:id])
    respond_with @ingredient
  end

  def new
    @ingredient = Ingredient.new
    respond_with @ingredient
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
  end

  def create
    @ingredient = Ingredient.new(params[:ingredient])

    respond_to do |format|
      if @ingredient.save
        format.html { redirect_to @ingredient, notice: 'Ingredient was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @ingredient = Ingredient.find(params[:id])

    respond_to do |format|
      if @ingredient.update_attributes(params[:ingredient])
        format.html { redirect_to @ingredient, notice: 'Ingredient was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @ingredient = Ingredient.find(params[:id])
    @ingredient.destroy

    respond_to do |format|
      format.html { redirect_to ingredients_url }
    end
  end

  private
  def get_available_cookbooks
    begin
      @available_cookbooks = ChefClientApi.cookbooks_list
    rescue Exception => ex
      flash[:error] = "Can't connect to chef server, there might be an error in your configuration. Exception message: #{ex.message}"
    end
  end

  private
  def retrieve_cookbooks
    @cookbooks = ChefClientApi.cookbooks_list
  end
end
