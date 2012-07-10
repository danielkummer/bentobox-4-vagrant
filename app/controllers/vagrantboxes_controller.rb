class VagrantboxesController < ApplicationController
  respond_to :html

  def index
    @vagrantboxes = Vagrantbox.all.to_a
    respond_with @vagrantboxes
  end

  def new
    @vagrantbox = Vagrantbox.new
    respond_with @vagrantbox
  end

  def edit
    @vagrantbox = Vagrantbox.find(params[:id])
    respond_with @vagrantbox
  end

  def create
    @vagrantbox = Vagrantbox.new(params[:vagrantbox])

    respond_to do |format|
      if @vagrantbox.save
        format.html { redirect_to vagrantboxes_path, notice: 'Vagrantbox was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @vagrantbox = Vagrantbox.find(params[:id])

    respond_to do |format|
      if @vagrantbox.update_attributes(params[:vagrantbox])
        format.html { redirect_to @vagrantbox, notice: 'Vagrantbox was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @vagrantbox = Vagrantbox.find(params[:id])
    @vagrantbox.destroy

    respond_to do |format|
      format.html { redirect_to vagrantboxes_url }
    end
  end
end
