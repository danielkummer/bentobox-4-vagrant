class User
  include Mongoid::Document
  include DeviseExt

  has_many :bentoboxes

  field :name

  validates :name, :presence => true

  attr_accessible :name

  before_save :assign_name

  def assign_name
    self.name = Devise::LdapAdapter.get_ldap_param(self.login, 'cn').first
  end

end
