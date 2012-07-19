require 'chef/api_client'
require 'chef/json_compat'


class User
  include Mongoid::Document
  include DeviseExt

  has_many :bentoboxes, dependent: :destroy
  attr_accessible :bentobox_ids, :client_name, :private_key

  validates :email, uniqueness: {case_sensitive: false}
  validates :email, format: {with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/,
                             message: "Invalid email"}

  field :client_name, type: String
  validates :client_name, uniqueness: true
  validates :client_name, format: {with: /^[\w-]+$/i,
                                   message: "Invalid client name, only alphanumerical - and _ allowed"}

  field :private_key, type: String




  attr_writer :chef_regenerate_private_key, :chef_is_admin

  def chef_regenerate_private_key?
    @chef_regenerate_private_key || false
  end

  def chef_is_admin?
    @chef_is_admin || false
  end


  before_validation :generate_client_name, :if => Proc.new { |user| user.client_name.empty? }
  before_save :update_chef_client, :if => Proc.new { |user| user.client_name_changed? }
  before_destroy :delete_chef_client

  def generate_client_name
    return unless self.client_name.empty?
    self.client_name = self.email.gsub /(@|\.)/, "@" => "_at_", "." => "_"
  end

  def update_chef_client
    ChefClient.update_client(self)
  end

  def delete_chef_client
    ChefClient.delete_client(self)
  end
end
