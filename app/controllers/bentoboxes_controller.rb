class BentoboxesController < ApplicationController
  respond_to :html
  respond_to :text, only: [:show]

  before_filter :authenticate_owner!, :only => [:edit, :update, :destroy]
  before_filter :grab_user_from_user_id

  #skip_filter :authenticate_user!, only: [:show]


  def index
    @bentoboxes = bentoboxes.all.to_a
    respond_with @bentoboxes
  end

  def show
    @bentobox = bentoboxes.find(params[:id])

    if params[:download]
      send_data(render_to_string, :filename => "Vagrantconfig", :type => "text/plain")
    else
      respond_with @bentobox
    end
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
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @bentobox = bentoboxes.find(params[:id])

    respond_to do |format|
      if @bentobox.update_attributes(params[:bentobox])
        format.html { redirect_to @bentobox, notice: 'Bentobox was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @bentobox = bentoboxes.find(params[:id])
    @bentobox.destroy

    respond_to do |format|
      format.html { redirect_to bentoboxes_url }
    end
  end

  private
  def grab_user_from_user_id
    @user = User.find(params[:user_id]) if params[:user_id]
  end

  def bentoboxes
    @user ? @user.bentoboxes : Bentobox.visible_to_user(current_user)
  end


  def authenticate_owner!
    if user_signed_in? && current_user.id.to_s == params[:user_id]
      return true
    end
    redirect_to user_path(current_user), :notice => "You can only edit your own bentoboxes."
    return false
  end
end
