require 'chef'

class ChefClient
  class << self
    def rest
      @rest ||= begin
        require 'chef/rest'
        Chef::Config[:node_name]= APP_CONFIG[:chef]['node_name']
        Chef::Config[:client_key]= APP_CONFIG[:chef]['client_key']
        Chef::Config[:chef_server_url]= APP_CONFIG[:chef]['chef_server_url']
        Chef::REST.new(Chef::Config[:chef_server_url])
      end
    end


    def connected?
      begin
        rest.get_rest("/clients/#{Chef::Config[:node_name]}")
      rescue Net::HTTPServerException => e
        #e.response.code == "409"
        return false
      end
      return true
    end

    def cookbooks_list
      return config_cookbooks if bypass_chef_server?
      env = APP_CONFIG[:chef]['environment'] || nil
      num_versions = APP_CONFIG[:chef]['all_versions'] ? "num_versions=all" : "num_versions=1"
      api_endpoint = env ? "/environments/#{env}/cookbooks?#{num_versions}" : "/cookbooks?#{num_versions}"
      cookbook_versions = rest.get_rest(api_endpoint)
      format_cookbook_list(cookbook_versions)
    end

    #{
    #  "name" : "monkeypants",
    #  "chef_type" : "client",
    #  "json_class" : "Chef::ApiClient",
    #  "public_key" : "RSA PUBLIC KEY",
    #  "_rev" : "1-68532bf2122a54464db6ad65a24e2225",
    #  "admin" : true
    #}
    #def get_client(user)
    #  rest.get_rest("clients/#{user.client_name}")
    #end

    def create_client(user)
      rest.post_rest("clients", {:name => user.client_name})
      #throws 409 on conflict
    end

    def update_client(user)
      params = {
        :name => user.client_name,
        :private_key => user.chef_regenerate_private_key?,
        :admin => user.chef_is_admin?
      }
      user.client_name_changed? ? name = user.client_name_was : name = user.client_name
      result = rest.put_rest("clients/#{name}", params) #other private_key => true for new private key
      result
    end

    def delete_client(user)
      rest.delete_rest("clients/#{user.client_name}")
    end

    private
    def format_cookbook_list(item)
      item.inject({}) do |cookbooks, (cookbook, versions)|
        cookbooks[cookbook] = cookbook
        cookbooks
      end
    end

    def bypass_chef_server?
      APP_CONFIG[:chef].has_key?('cookbooks')
    end

    def config_cookbooks
      APP_CONFIG[:chef]['cookbooks'].split(',').inject({}) do |result, cookbook|
        cookbook = cookbook.strip
        result[cookbook] = cookbook
        result
      end
    end

  end
end