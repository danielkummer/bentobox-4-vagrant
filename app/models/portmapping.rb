class Portmapping
  include Mongoid::Document

  embedded_in :ingredient, :inverse_of => :portmappings

  field :mapping, type: String

  validates :mapping,
            format: {with: /^(6553[0-5]|655[0-2]\d|65[0-4]\d\d|6[0-4]\d{3}|[1-5]\d{4}|[1-9]\d{0,3}|0):(6553[0-5]|655[0-2]\d|65[0-4]\d\d|6[0-4]\d{3}|[1-5]\d{4}|[1-9]\d{0,3}|0)$/,
                     message: "Wrong format, please use for example 80:8888 for vm port 80 and host port 8888."}
  validates :mapping, presence: true

  attr_accessible :mapping
end
