class AppConfiguration
  include Mongoid::Document
  field :name, type: String
  field :value, type: String

  validates :name, uniqueness: true
  attr_readonly :name


  #todo this is seed data!!
  def self.defaults
    {
      validation_key_file_name: 'validation.pem',
      validation_client_name: 'chef-validator',
      chef_node_name: 'bentobox',
      chef_client_key: 'config/production.pem',
      chef_server_api_url: 'http://vagrant.namics.com:4000',
      chef_server_admin_url: 'http://vagrant.namics.com:4040',
    }
  end
end
