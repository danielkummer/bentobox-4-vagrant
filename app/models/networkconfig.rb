class Networkconfig
  include Mongoid::Document
  field :type, type: String
  field :second_parameter, type: String, default: ""
  field :third_parameter, type: String, default: ""

  embedded_in :ingredient, :inverse_of => :networkconfig

  validates :type, :second_parameter, presence: true
  validates :type, :inclusion => %w(hostonly bridged)

  attr_accessible :type, :second_parameter, :third_parameter

  def to_s
    result = ""
    result << ":#{type}" unless type.nil?
    result << ", #{second_parameter}" unless second_parameter.empty?
    result << ", #{third_parameter}" unless third_parameter.empty?
    result
  end
end
