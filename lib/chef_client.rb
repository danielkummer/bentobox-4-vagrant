require 'chef'

class ChefClient
  class Exceptions
    class ConfigurationError < RuntimeError; end
    class ConnectionError < RuntimeError; end
  end

  class << self



    def rest
      @rest ||= begin
        require 'chef/rest'
        Chef::Config[:node_name] = APP_CONFIG[:chef_node_name]
        Chef::Config[:client_key] = APP_CONFIG[:chef_client_key]
        Chef::Config[:chef_server_url] = APP_CONFIG[:chef_server_url]
        Chef::Config[:http_retry_count] = 1 #else will try 5 times to reconnect

        Chef::REST.new(Chef::Config[:chef_server_url])
      end
    end

    def connected?
      begin
        rest.get_rest("/clients/#{APP_CONFIG[:chef_node_name]}")
      rescue Exception
        return false
      end
      return true
    end

    #todo implement caching
    def cookbooks_list
      return config_cookbooks if bypass_chef_server?

      env = APP_CONFIG[:chef_environment] || nil
      num_versions = APP_CONFIG[:chef_cookbook_all_versions] ? "num_versions=all" : "num_versions=1"
      api_endpoint = env ? "/environments/#{env}/cookbooks?#{num_versions}" : "/cookbooks?#{num_versions}"

      begin
        cookbook_versions = rest.get_rest(api_endpoint)
        format_cookbook_list(cookbook_versions)
      rescue Exception => e
        handle_authentication_exceptions(e)
      end
    end

    def create_client(user)
      begin
        rest.post_rest("clients", {:name => user.client_name})
      rescue Exception => e
        handle_authentication_exceptions(e)
        if e.response.code == "404"
          raise ChefClient::Exceptions::ConfigurationError
        end
      end
    end

    def delete_client(user)
      user.client_name_changed? ? name = user.client_name_was : name = user.client_name
      begin
        rest.delete_rest("clients/#{name}")
      rescue Exception => e
        handle_authentication_exceptions(e, false)
        if e.response.code == "404"
          Rails.logger.debug "Chef delete client - client #{name} not found"
        end
      end
    end

    private
    def handle_authentication_exceptions(exception, raise_exception = true)
      if exception.instance_of?(Net::HTTPServerException) and (exception.response.code == '401' || exception.response.code == '403')
        raise ChefClient::Exceptions::ConfigurationError
      else if exception.instance_of?(Errno::ECONNREFUSED)
        raise ChefClient::Exceptions::ConnectionError
      end
        raise exception if raise_exception
      end
    end

    def format_cookbook_list(item)
      item.inject({}) do |cookbooks, (cookbook, versions)|
        cookbooks[cookbook] = cookbook
        cookbooks
      end
    end

    #deprecated #todo remove
    def bypass_chef_server?
      APP_CONFIG.has_key? :cookbooks
    end

    def config_cookbooks
      APP_CONFIG[:cookbooks].split(',').inject({}) do |result, cookbook|
        cookbook = cookbook.strip
        result[cookbook] = cookbook
        result
      end
    end

  end
end