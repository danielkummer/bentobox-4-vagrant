class Ingredient
  include Mongoid::Document
  embeds_many :portmappings

  field :name
  field :snippet

  validates :name, :snippet, :presence => true
  validates :name, :uniqueness => true
end
