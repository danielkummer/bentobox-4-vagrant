module DeviseExt
  extend ActiveSupport::Concern

  module ClassMethods

  end

  module InstanceMethods

  end

  def self.included(base)
    base.send :include, InstanceMethods
    base.send :extend, ClassMethods

    base.send :devise, :ldap_authenticatable, :rememberable, :trackable

    ## Ldap authenticable
    base.send :field, :login, :type => String, :default => ""
    base.send :field, :encrypted_password, :type => String, :default => ""

    base.send :validates_presence_of, :login
    #base.send :validates_presence_of, :encrypted_password

    ## Recoverable
    base.send :field, :reset_password_token, :type => String
    base.send :field, :reset_password_sent_at, :type => Time

    ## Rememberable
    base.send :field, :remember_created_at, :type => Time

    ## Trackable
    base.send :field, :sign_in_count, :type => Integer, :default => 0
    base.send :field, :current_sign_in_at, :type => Time
    base.send :field, :last_sign_in_at, :type => Time
    base.send :field, :current_sign_in_ip, :type => String
    base.send :field, :last_sign_in_ip, :type => String

    base.send :index, {login: 1}, {unique: true, name: "login_index"}

    base.send :attr_accessible, :login, :remember_me
  end

end
