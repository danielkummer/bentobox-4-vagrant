class Category
  include Mongoid::Document

  field :name, type: String
  has_many :ingredients

  validates :name, presence: true
  validates :name, uniqueness: true

  attr_accessible :name, :ingredients
end
