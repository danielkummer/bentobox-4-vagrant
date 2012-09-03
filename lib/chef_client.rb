require 'chef'

class ChefClient
  class Exceptions
    class ConfigurationError < RuntimeError;
    end
    class ConnectionError < RuntimeError;
    end
  end

  class << self
    def rest
      @rest ||= begin
        require 'chef/rest'
        Chef::Config[:node_name] = APP_CONFIG[:chef_node_name]
        Chef::Config[:client_key] = APP_CONFIG[:chef_client_key]
        Chef::Config[:chef_server_api_url] = APP_CONFIG[:chef_server_api_url]
        Chef::Config[:http_retry_count] = 1   #else will try 5 times to reconnect
        Chef::REST.new(Chef::Config[:chef_server_api_url])

        Rails.logger.debug "Creating REST interface with config; #{Chef::Config.inspect}"
      end
    end

    def connected?
      begin
        answer = rest.get_rest("/clients/#{APP_CONFIG[:chef_node_name]}")
        Rails.logger.debug "chef server connection test, got answer: #{answer}"
      rescue Exception
        return false
      end
      return true
    end

    #todo implement caching
    def cookbooks_list
      env = APP_CONFIG[:chef_environment] || nil
      num_versions = APP_CONFIG[:chef_cookbook_all_versions] ? "num_versions=all" : "num_versions=1"
      api_endpoint = env ? "/environments/#{env}/cookbooks?#{num_versions}" : "/cookbooks?#{num_versions}"
      begin
        Rails.logger.debug "listing cookbook versions, api endpoint: #{api_endpoint}"
        cookbook_versions = rest.get_rest(api_endpoint)
        format_cookbook_list(cookbook_versions)
      rescue Exception => e
        handle_authentication_exceptions(e)
      end
    end

    def get_client(user)
      begin
        result = rest.get_rest("clients#{user.client_name}")
        Rails.logger.debug "getting client #{user.client_name}, got answer: #{result}"
        result
      rescue Exception => e
        handle_authentication_exceptions(e)
      end
    end

    def create_client(user)
      begin
        result = rest.post_rest("clients", {:name => user.client_name})
        Rails.logger.debug "creating new client #{user.client_name}, got answer: #{result}"
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
        Rails.logger.debug "client #{name} deleted"
      rescue Exception => e
        handle_authentication_exceptions(e, false)
        if e.response.code == "404"
          Rails.logger.debug "Chef delete client - client #{name} not found"
        end
      end
    end

    private
    def handle_authentication_exceptions(exception, raise_exception = true)
      Rails.logger.debug "try handling exception: #{exception}, #{exception.message}, raising again: #{raise_exception}"
      if exception.instance_of?(Net::HTTPServerException) and (exception.response.code == '401' || exception.response.code == '403')
        Rails.logger.debug "chef api returned 401 or 403 error - it's probably a configuration error"
        raise ChefClient::Exceptions::ConfigurationError
      else
        if exception.instance_of?(Errno::ECONNREFUSED)
          Rails.logger.debug "chef api returned connection refused error - it's probably a configuration error"
          raise ChefClient::Exceptions::ConnectionError
        end
        raise exception if raise_exception
      end
    end

    def format_cookbook_list(item)
      Rails.logger.debug "formating #{item.size} cookbooks..."
      item.inject({}) do |cookbooks, (cookbook, versions)|
        cookbooks[cookbook] = cookbook
        cookbooks
      end
    end

  end
end