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

    def cookbooks_list
      return config_cookbooks if bypass_chef_server?

      env = APP_CONFIG[:chef]['environment'] || nil
      num_versions = APP_CONFIG[:chef]['all_versions'] ? "num_versions=all" : "num_versions=1"
      api_endpoint = env ? "/environments/#{env}/cookbooks?#{num_versions}" : "/cookbooks?#{num_versions}"
      cookbook_versions = rest.get_rest(api_endpoint)
      format_cookbook_list(cookbook_versions)
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