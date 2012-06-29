class Portmapping
  include Mongoid::Document
  embedded_in :ingredient, :inverse_of => :portmappings

  field :port, type: Integer

  validates :port, numericality: { only_integer: true}
  validates :port, inclusion: {in: 1025..65535}
end
