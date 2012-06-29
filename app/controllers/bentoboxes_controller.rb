class BentoboxesController < ApplicationController
  respond_to :html
  respond_to :text, only: [:show]

  def index
    @bentoboxes = Bentobox.all

    respond_with @bentoboxes
  end

  def show
    @bentobox = Bentobox.find(params[:id])
    respond_with @bentobox
  end

  def new
    @bentobox = Bentobox.new
    @ingredients = Ingredient.all
    respond_with @bentobox
  end

  def edit
    @bentobox = Bentobox.find(params[:id])
    @ingredients = Ingredient.all
  end

  def create
    @bentobox = Bentobox.new(params[:bentobox])

    respond_to do |format|
      if @bentobox.save
        format.html { redirect_to @bentobox, notice: 'Bentobox was successfully created.' }
        format.json { render json: @bentobox, status: :created, location: @bentobox }
      else
        format.html { render action: "new" }
        format.json { render json: @bentobox.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @bentobox = Bentobox.find(params[:id])

    respond_to do |format|
      if @bentobox.update_attributes(params[:bentobox])
        format.html { redirect_to @bentobox, notice: 'Bentobox was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bentobox.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bentobox = Bentobox.find(params[:id])
    @bentobox.destroy

    respond_to do |format|
      format.html { redirect_to bentoboxes_url }
      format.json { head :no_content }
    end
  end
end
