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
  before_save :create_or_update_chef_client, :if => Proc.new { |user| user.client_name_changed? or user.new_record? }
  before_destroy :delete_chef_client, :unless => Proc.new { |user| user.private_key.blank? }

  def generate_client_name
    return unless self.client_name.blank?
    self.client_name = self.email.gsub /(@|\.)/, "@" => "_at_", "." => "_"
    logger.debug "generate new client name: #{self.client_name}"
  end

  def create_or_update_chef_client

    begin
      if ChefClient.get_client(self).has_key?('public_key')
        client = ChefClient.update_client(self)
      else
        client = ChefClient.create_client(self)
      end

      if client.has_key?('private_key')
        logger.debug "got new chef client private key for user #{self.email}"
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
