class Ingredient
  include Mongoid::Document
  embeds_many :portmappings
  belongs_to :category

  #has_and_belongs_to_many :bentoboxes, :inverse_of => :ingredients

  field :name
  field :snippet

  validates :name, :snippet, :presence => true
  validates :name, :uniqueness => true

  accepts_nested_attributes_for :portmappings
end
