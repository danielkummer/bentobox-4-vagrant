class NetworkConfig
  include Mongoid::Validations

  attr_reader :type, :second_param, :third_param

  validates :second_param, :format => { :if => :type_is_hostonly?, :with => /[HERE IS VALID IP]/}


  def initialize(type, second_param, third_param)
    @type, @second_param, @third_param = type, second_param, third_param
  end

  def to_s
    result = ""
    result << ":#{type}" unless type.nil?
    result << ", #{second_param}" unless second_param.empty?
    result << ", #{third_param}" unless third_param.empty?
    result
  end

  def mongoize
    {'type' => type, 'second_param' => second_param, 'third_param' => third_param}
  end

  class << self
    def demongoize(object)
      if object.nil?
        NetworkConfig.new("", "", "")
      else
        NetworkConfig.new(object['type'], object['second_param'], object['third_param'])
      end
    end

    def mongoize(object)
      object
    end

    def evolve(object)
      if object.is_a?(NetworkConfig)
        [object.type, object.second_param, object.third_param]
      else
        object
      end
    end
  end

  private
  def type_is_hostonly?
    type == "hostonly"
  end
end