require 'chef'

class Cookbook

  def initialize
    log.debug "started cookbook"
    Chef::Config[:node_name]= APP_CONFIG[:node_name]
    Chef::Config[:client_key]= APP_CONFIG[:client_key]
    Chef::Config[:chef_server_url]= APP_CONFIG[:chef_server_url]
  end

  def list
    cookbooks = Chef::Cookbook.list
    cookbooks
  end

end



#Chef::Node.list.each do |node|
#puts node.first
#end