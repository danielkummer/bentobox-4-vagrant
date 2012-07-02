class Vagrantbox
  include Mongoid::Document
  has_many :bentoboxes

  field :name, type: String
  mount_uploader :box, VagrantboxUploader

  validates :name, :path, :box, :presence => true
  validates :name, :uniqueness => true

end
