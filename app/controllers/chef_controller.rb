class ChefController < ApplicationController

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
    begin
      ChefClient.delete_client(user)
      message = "Chef client deleted successfully"
    rescue Net::HTTPServerException => e
      message = e.message
    end
    user.update_attribute :private_key, nil
    redirect_to user, notice: message
  end

end
