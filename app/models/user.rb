class User
  include Mongoid::Document
  has_many :bentoboxes
  field :name
  validates :name, :presence => true
end
