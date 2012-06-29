class Vagrantbox
  include Mongoid::Document
  field :name, type: String
  field :path, type: String

  has_many :bentoboxes

  validates :name, :path, :presence => true
  validates :name, :uniqueness => true
end
