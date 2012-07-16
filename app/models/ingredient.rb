class Ingredient
  include Mongoid::Document

  belongs_to :category
  #http://stackoverflow.com/questions/5078661/field-for-and-nested-form-with-mongoid

  embeds_one :networkconfig
  embeds_many :portmappings
  embeds_many :share_folders
  has_and_belongs_to_many :bentoboxes, :inverse_of => :ingredients

  field :name, type: String
  field :cookbooks, type: Array


  validates :name, presence: true, uniqueness: true
  validates :category, presence: true


  accepts_nested_attributes_for :networkconfig,
                                :portmappings,
                                :share_folders,
                                allow_destroy: true

  attr_accessible :name,
                  :category,
                  :cookbooks,
                  :portmappings_attributes, :portmappings,
                  :share_folders_attributes, :share_folders,
                  :networkconfig_attributes, :networkconfig

  scope :with_network_config, excludes(:networkconfig => nil)
  scope :with_share_folders, excludes(:share_folders => nil)
  scope :with_portmappings, excludes(:portmappings => nil)


  #remove stupid empty array content form form
  before_validation do |model|
    model.cookbooks.reject!(&:blank?) if model.cookbooks
  end

end
