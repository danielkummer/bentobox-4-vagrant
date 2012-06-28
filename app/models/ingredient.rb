class Ingredient
  include Mongoid::Document
  embeds_many :portmappings

  field :name
  field :snippet
end
