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


  def create_client
    user = User.find(params[:user_id])
    begin
      client = ChefClient.create_client(user)
      if client.has_key?('private_key')
        if user.update_attribute(:private_key, client['private_key'])
          message = 'User was successfully updated.'
        else
          message = 'Unable to update private key'
        end
      else
        message = 'Couldn\'t get private key'
      end

    rescue Net::HTTPServerException => e
      message = e.message
    end
    redirect_to user, notice: message
  end

  def delete_client
    user = User.find(params[:user_id])
    ChefClient.delete_client(user)
    user.update_attribute :private_key, nil
    message = "Chef client deleted successfully"

    redirect_to user, notice: message
  end

end
