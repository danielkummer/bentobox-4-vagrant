class User
  include Mongoid::Document
  include DeviseExt

  has_many :bentoboxes
end
