class Ingredient
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes

  embeds_many :portmappings
  embeds_many :share_folders
  belongs_to :category

  has_and_belongs_to_many :bentoboxes, :inverse_of => :ingredients

  field :name
  field :cookbooks
  field :network_config, type: NetworkConfig

  validates :name, :presence => true
  validates :name, :uniqueness => true

  accepts_nested_attributes_for :portmappings, :share_folders,
                                allow_destroy: true

end
