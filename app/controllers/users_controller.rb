require 'devise_helper.rb'
class UsersController < ApplicationController
  respond_to :html

  before_filter :authenticate_owner!


  def show
    @user = User.find(params[:id])
    respond_with @user
  end


  def edit
    @user = User.find(params[:id])
    respond_with @user
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to root_url }
    end
  end

  def download_key
    send_data current_user.private_key, :disposition => 'attachment', :filename => "client.pem"
  end


  private
    def authenticate_owner!
      if user_signed_in? && current_user.id.to_s == params[:id]
        return true
      end
      redirect_to user_path(current_user), :notice => "You can only edit your own profile."
      return false
    end
end
