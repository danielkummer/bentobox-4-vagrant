class Ingredient
  include Mongoid::Document
  embeds_many :portmappings
  embeds_many :share_folders
  belongs_to :category

  has_and_belongs_to_many :bentoboxes, :inverse_of => :ingredients

  field :name
  field :cookbooks
  field :share_folder
  field :network_config


  validates :name, :presence => true
  validates :name, :uniqueness => true

  accepts_nested_attributes_for :portmappings, :share_folders

end
