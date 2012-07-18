class ChefController < ApplicationController

  def create_client
    #must use reset-api directly when not using couchdb
    user = current_user

    r = Chef::REST.new(Chef::Config[:chef_server_url])
    begin
      r.post_rest("clients", {:name => user.client_name})
    rescue Net::HTTPServerException => e
      # If that fails, go ahead and try and update it
      if e.response.code == "409"
        r.put_rest("clients/#{user.client_name}", {:name => user.client_name})
        #r.put_rest("clients/#{user.client_name}", { :name => user.client_name, :private_key => new_key })
      else
        raise e
      end
    end

    #client = Chef::REST.new(Chef::Config[:chef_server_url]).post_rest("clients", {name: user.client_name})


    #output = edit_data(client)

    # Chef::ApiClient.save will try to create a client and if it exists will update it instead silently

    # We only get a private_key on client creation, not on client update.
    if client['private_key']
      user.private_key = client['private_key']
    end

    flash[:notice] = "Couldn't get private key" if user.private_key.empty?
    redirect_to user_path(current_user)


  end

end
