class User
  include Mongoid::Document
  has_many :bentoboxes

  field :name




end
