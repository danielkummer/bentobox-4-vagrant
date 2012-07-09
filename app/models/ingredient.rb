class Ingredient
  include Mongoid::Document

  belongs_to :category
  #http://stackoverflow.com/questions/5078661/field-for-and-nested-form-with-mongoid

  embeds_one :networkconfig
  embeds_many :portmappings
  embeds_many :share_folders
  has_and_belongs_to_many :bentoboxes, :inverse_of => :ingredients

  field :name
  field :cookbooks

  validates :name, presence: true, uniqueness: true
  validates :category, presence: true

  validates_associated :networkconfig
  accepts_nested_attributes_for :networkconfig, allow_destroy: true

  attr_accessible :name, :category, :cookbooks, :portmappings, :share_folders, :networkconfig_attributes

  scope :with_network_config, excludes(:networkconfig => nil)

end
