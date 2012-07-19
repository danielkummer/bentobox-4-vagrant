class ChefController < ApplicationController
  before_filter :authenticate_owner!

=begin
  def client
    user = User.find(params[:user_id])

    case params[:action]
      when 'create'
        create(user)
      when 'delete'
        delete(user)
      else
        redirect_to user, notice: "Action not found"
    end

  end
=end


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
