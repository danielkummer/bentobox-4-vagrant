class BentoboxesController < ApplicationController
  respond_to :html
  respond_to :text, only: [:show]

  before_filter :authenticate_owner!, :only => [:edit, :update, :destroy]
  before_filter :grab_user_from_user_id
  skip_filter :authenticate_user!, only: [:show]


  def index
    @bentoboxes = bentoboxes.all
    #todo show where user = current user or public = true
    respond_with @bentoboxes
  end

  def show
    @bentobox = bentoboxes.find(params[:id])
    respond_with @bentobox
  end

  def new
    @bentobox = bentoboxes.new
    respond_with @bentobox
  end

  def edit
    @bentobox = bentoboxes.find(params[:id])
    respond_with @bentobox
  end

  def create
    @bentobox = bentoboxes.new(params[:bentobox])

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
    @bentobox = bentoboxes.find(params[:id])

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
    @bentobox = bentoboxes.find(params[:id])
    @bentobox.destroy

    respond_to do |format|
      format.html { redirect_to bentoboxes_url }
      format.json { head :no_content }
    end
  end

  private
  def grab_user_from_user_id
    @user = User.find(params[:user_id]) if params[:user_id]
  end

  def bentoboxes
    @user ? @user.bentoboxes : Bentobox
  end


  def authenticate_owner!
    if user_signed_in? && current_user.id.to_s == params[:user_id]
      return true
    end
    redirect_to user_path(current_user), :notice => "You can only edit your own bentoboxes."
    return false
  end


end
