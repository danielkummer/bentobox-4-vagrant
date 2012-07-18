class ChefController < ApplicationController

  def create_client
    #must use reset-api directly when not using couchdb
      user = current_user

      client = Chef::ApiClient.new
      client.name(user.client_name)


      #output = edit_data(client)

      # Chef::ApiClient.save will try to create a client and if it exists will update it instead silently
      client.save

      # We only get a private_key on client creation, not on client update.
      if client['private_key']
        user.private_key = client['private_key']
      end

      flash[:notice] = "Couldn't get private key" if user.private_key.empty?
      redirect_to user_path(current_user)


  end

end
