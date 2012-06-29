class Category
  include Mongoid::Document
  field :name
  has_many :ingredients

  validates :name, presence: true
  validates :name, uniqueness: true
end
