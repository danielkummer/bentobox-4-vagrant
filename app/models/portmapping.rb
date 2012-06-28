class Portmapping
  include Mongoid::Document
  embedded_in :ingredient

  field :port, type: Integer

  validates_format_of :port, with: /^[0-9]*$/i
end
