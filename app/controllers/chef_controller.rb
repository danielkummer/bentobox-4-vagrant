class ChefController < ApplicationController
  before_filter :authenticate_owner!, except: [:status]
  skip_filter :authenticate_user!, only: [:status]

  respond_to :json


  def status
    result = Rails.cache.fetch('chef_server_reachable', :expires_in => 5.minutes) do
      ChefClient.connected?.to_s
    end
    respond_with({:reachable => result}.to_json)
  end


  def update_client
    user = User.find(params[:user_id])
    begin
      user.create_chef_client
    rescue Exception => e
      message = e.message
    end
    redirect_to user, notice: message
  end

end
