class Vagrantbox
  include Mongoid::Document
  field :name, type: String
  field :path, type: String

  has_and_belongs_to_many :bentoboxes
end
