require 'chef'

class ChefClient
  def rest
    @rest ||= begin
      require 'chef/rest'
      Chef::Config[:node_name]= APP_CONFIG[:node_name]
      Chef::Config[:client_key]= APP_CONFIG[:client_key]
      Chef::Config[:chef_server_url]= APP_CONFIG[:chef_server_url]
      Chef::REST.new(Chef::Config[:chef_server_url])
    end
  end

  def list
    env = APP_CONFIG[:environment] || nil
    num_versions = APP_CONFIG[:all_versions] ? "num_versions=all" : "num_versions=1"
    api_endpoint = env ? "/environments/#{env}/cookbooks?#{num_versions}" : "/cookbooks?#{num_versions}"
    cookbook_versions = rest.get_rest(api_endpoint)
    format_cookbook_list(cookbook_versions)
  end

  private
  def format_cookbook_list(item)
    versions_by_cookbook = item.inject({}) do |collected, (cookbook, versions)|
      collected[cookbook] = versions["versions"].map { |v| v['version'] }
      collected
    end
    key_length = versions_by_cookbook.empty? ? 0 : versions_by_cookbook.keys.map { |name| name.size }.max + 2
    versions_by_cookbook.sort.map do |cookbook, versions|
      "#{cookbook.ljust(key_length)} #{versions.join('  ')}"
    end

  end
end