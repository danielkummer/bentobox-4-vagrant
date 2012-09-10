class ChefController < ApplicationController
  before_filter :authenticate_owner!, except: [:status]
  respond_to :json

  def status
    result = Rails.cache.fetch('chef_server_reachable', :expires_in => 5.minutes) do
      ChefClientApi.connected?.to_s
    end
    respond_with({:reachable => result}.to_json)
  end

  def client_status
    user = User.find(params[:id])
    begin
      ChefClientApi.get_client(user)
      result = true
    rescue Exception
      result = false
    end
    respond_with({:client_exists => result}.to_json)
  end

end
