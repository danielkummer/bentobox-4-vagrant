require 'chef'

class ChefClientApi
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
        Chef::Config[:node_name] = AppConfiguration.get('chef client node name')
        Chef::Config[:client_key] = AppConfiguration.get('chef client key')
        Chef::Config[:chef_server_api_url] = AppConfiguration.get('chef server api url')
        Chef::Config[:http_retry_count] = 1   #else will try 5 times to reconnect
        Chef::Config[:client_registration_retries] = 1 #else will try 5 times to create client - results in 409 error

        Rails.logger.debug "Creating REST interface with config; #{Chef::Config.inspect}"

        Chef::REST.new(Chef::Config[:chef_server_api_url])
      end
    end

    def connected?
      begin
        answer = rest.get_rest("clients/#{AppConfiguration.get('chef client node name')}")
        Rails.logger.debug "chef server connection test, got answer: #{answer}"
      rescue Exception
        return false
      end
      return true
    end

    def get_client(user)
      begin
        result = rest.get_rest("clients/#{user.client_name}")
        Rails.logger.debug "getting client #{user.client_name}, got answer: #{result}"
        result
      rescue Exception => e
        handle_authentication_exceptions(e)
      end
    end

     #todo implement caching
    def cookbooks_list
      env = AppConfiguration.get('chef environment')
      num_versions = AppConfiguration.get('chef cookbook versions').blank? ? "num_versions=1" : AppConfiguration.get('chef cookbook versions')
      api_endpoint = !env.blank? ? "/environments/#{env}/cookbooks?#{num_versions}" : "/cookbooks?#{num_versions}"
      begin
        Rails.logger.debug "listing cookbook versions, api endpoint: #{api_endpoint}"
        cookbook_versions = rest.get_rest(api_endpoint)
        format_cookbook_list(cookbook_versions)
      rescue Exception => e
        handle_authentication_exceptions(e)
      end
    end

    def create_client(user)
      begin
        result = rest.post_rest("clients", {:name => user.client_name})
        Rails.logger.debug "creating new client #{user.client_name}, got answer: #{result}"
        result
      rescue Exception => e
        handle_authentication_exceptions(e)
        if e.response.code == "404"
          raise ChefClientApi::Exceptions::ConfigurationError
        end
      end
    end

    def delete_client(user)
      user.client_name_changed? ? name = user.client_name_was : name = user.client_name
      begin
        result = rest.delete_rest("clients/#{name}")
        Rails.logger.debug "client #{name} deleted"
        result
      rescue Exception => e
        if e.respond_to?(:response) && e.response.code == "404"
          Rails.logger.debug "Chef delete client - client #{name} not found"
        else
          handle_authentication_exceptions(e)
        end
      end
    end

    private
    def handle_authentication_exceptions(exception)
      Rails.logger.debug "try handling exception: #{exception}, #{exception.message}"
      if exception.instance_of?(Net::HTTPServerException) and (exception.response.code == '401' || exception.response.code == '403')
        Rails.logger.debug "chef api returned 401 or 403 error - it's probably a configuration error"
        raise ChefClientApi::Exceptions::ConfigurationError
      else
        if exception.instance_of?(Errno::ECONNREFUSED)
          Rails.logger.debug "chef api returned connection refused error - it's probably a configuration error"
          raise ChefClientApi::Exceptions::ConnectionError
        end
        Rails.logger.debug "unable to handle chef api exception - propagating..."
        raise exception
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