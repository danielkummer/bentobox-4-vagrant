class User
  include Mongoid::Document
  has_many :bentoboxes
  field :name
  validates :name, :presence => true

  devise :ldap_authenticatable, :rememberable, :trackable

  ## Ldap authenticable
  field :login, :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  validates_presence_of :login
  validates_presence_of :encrypted_password

  ## Recoverable
  field :reset_password_token, :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count, :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at, :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip, :type => String

  index({ login: 1 }, { unique: true, name: "login_index" })

  attr_accessible :name, :login, :remember_me

end
