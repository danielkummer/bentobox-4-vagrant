class VagrantboxesController < ApplicationController
  # GET /vagrantboxes
  # GET /vagrantboxes.json
  def index
    @vagrantboxes = Vagrantbox.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vagrantboxes }
    end
  end

  # GET /vagrantboxes/1
  # GET /vagrantboxes/1.json
  def show
    @vagrantbox = Vagrantbox.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vagrantbox }
    end
  end

  # GET /vagrantboxes/new
  # GET /vagrantboxes/new.json
  def new
    @vagrantbox = Vagrantbox.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vagrantbox }
    end
  end

  # GET /vagrantboxes/1/edit
  def edit
    @vagrantbox = Vagrantbox.find(params[:id])
  end

  # POST /vagrantboxes
  # POST /vagrantboxes.json
  def create
    @vagrantbox = Vagrantbox.new(params[:vagrantbox])

    respond_to do |format|
      if @vagrantbox.save
        format.html { redirect_to @vagrantbox, notice: 'Vagrantbox was successfully created.' }
        format.json { render json: @vagrantbox, status: :created, location: @vagrantbox }
      else
        format.html { render action: "new" }
        format.json { render json: @vagrantbox.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /vagrantboxes/1
  # PUT /vagrantboxes/1.json
  def update
    @vagrantbox = Vagrantbox.find(params[:id])

    respond_to do |format|
      if @vagrantbox.update_attributes(params[:vagrantbox])
        format.html { redirect_to @vagrantbox, notice: 'Vagrantbox was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vagrantbox.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vagrantboxes/1
  # DELETE /vagrantboxes/1.json
  def destroy
    @vagrantbox = Vagrantbox.find(params[:id])
    @vagrantbox.destroy

    respond_to do |format|
      format.html { redirect_to vagrantboxes_url }
      format.json { head :no_content }
    end
  end
end
