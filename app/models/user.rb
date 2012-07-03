class User
  include Mongoid::Document
  include DeviseExt

  has_many :bentoboxes

  field :name

  validates :name, :presence => true

  attr_accessible :name

end
