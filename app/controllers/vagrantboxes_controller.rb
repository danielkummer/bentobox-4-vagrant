class VagrantboxesController < ApplicationController
  before_filter :search_vagrant_boxes, only: [:new, :edit]

  def index
    @vagrantboxes = Vagrantbox.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vagrantboxes }
    end
  end

  def show
    @vagrantbox = Vagrantbox.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vagrantbox }
    end
  end

  def new
    @vagrantbox = Vagrantbox.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vagrantbox }
    end
  end

  def edit
    @vagrantbox = Vagrantbox.find(params[:id])
  end

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

  def destroy
    @vagrantbox = Vagrantbox.find(params[:id])
    @vagrantbox.destroy

    respond_to do |format|
      format.html { redirect_to vagrantboxes_url }
      format.json { head :no_content }
    end
  end

  private
  def search_vagrant_boxes
    select_extensions = [".box"]
    box_paths = Dir["#{Rails.root}/public/**/*"].select {|e| select_extensions.include?(File.extname(e))}
    @boxes = box_paths.collect { |path| [File.basename(path, '.box'), path]}
  end
end
