class Vagrantbox
  include Mongoid::Document
  has_many :bentoboxes, dependent: :restrict

  field :name, type: String
  mount_uploader :box, VagrantboxUploader

  validates :name, :box, :presence => true
  validates :name, :uniqueness => true

  attr_accessible :name, :box, :box_cache

end
