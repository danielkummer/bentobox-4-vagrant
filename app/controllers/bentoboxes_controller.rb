class BentoboxesController < ApplicationController
  # GET /bentoboxes
  # GET /bentoboxes.json
  def index
    @bentoboxes = Bentobox.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bentoboxes }
    end
  end

  # GET /bentoboxes/1
  # GET /bentoboxes/1.json
  def show
    @bentobox = Bentobox.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bentobox }
    end
  end

  # GET /bentoboxes/new
  # GET /bentoboxes/new.json
  def new
    @bentobox = Bentobox.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bentobox }
    end
  end

  # GET /bentoboxes/1/edit
  def edit
    @bentobox = Bentobox.find(params[:id])
  end

  # POST /bentoboxes
  # POST /bentoboxes.json
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

  # PUT /bentoboxes/1
  # PUT /bentoboxes/1.json
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

  # DELETE /bentoboxes/1
  # DELETE /bentoboxes/1.json
  def destroy
    @bentobox = Bentobox.find(params[:id])
    @bentobox.destroy

    respond_to do |format|
      format.html { redirect_to bentoboxes_url }
      format.json { head :no_content }
    end
  end
end
