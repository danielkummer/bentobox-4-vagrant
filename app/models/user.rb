class User
  include Mongoid::Document
  field :name

  attr_accessible :name
end
