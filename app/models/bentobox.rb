class Bentobox
  include Mongoid::Document
  belongs_to :user
  has_and_belongs_to_many :ingredients #, inverse_of: nil
  has_one :vagrantbox

  field :name
  field :description
  field :public, type: Boolean

  attr_accessible :ingredient_ids
end
