class Bentobox
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :public, type: Boolean
end
