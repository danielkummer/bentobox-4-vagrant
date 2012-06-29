class Ingredient
  include Mongoid::Document
  embeds_many :portmappings
  has_and_belongs_to_many :bentoboxes
  belongs_to :category

  field :name
  field :snippet

  validates :name, :snippet, :presence => true
  validates :name, :uniqueness => true

  accepts_nested_attributes_for :portmappings
end
