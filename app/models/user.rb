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


  before_validation :generate_client_name, :if => Proc.new { |user| user.client_name.blank? }
  before_save :regenerate_chef_client, :if => Proc.new { |user| user.client_name_changed? }
  before_destroy :delete_chef_client, :unless => Proc.new { |user| user.private_key.blank? }

  def generate_client_name
    return unless self.client_name.empty?
    self.client_name = self.email.gsub /(@|\.)/, "@" => "_at_", "." => "_"
  end

  def regenerate_chef_client
    delete_chef_client
    begin
      client = ChefClient.create_client(self)
      if client.has_key?('private_key')
        self.private_key = client['private_key']
      end
    rescue Net::HTTPServerException => e
      errors.add(:client_name, e.message)
      raise e.message
    end
  end

  def delete_chef_client
    ChefClient.delete_client(self)
  end
end
