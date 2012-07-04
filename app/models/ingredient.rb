class Ingredient
  include Mongoid::Document

  embeds_one :networkconfig
  #http://stackoverflow.com/questions/5078661/field-for-and-nested-form-with-mongoid

  embeds_many :portmappings
  embeds_many :share_folders

  belongs_to :category

  has_and_belongs_to_many :bentoboxes, :inverse_of => :ingredients

  field :name
  field :cookbooks

  validates :name, :presence => true
  validates :name, :uniqueness => true


  accepts_nested_attributes_for :portmappings,
                                :share_folders,
                                :networkconfig,
                                allow_destroy: true

end
