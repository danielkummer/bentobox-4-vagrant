class NetworkConfig

  attr_reader :type, :second_param, :third_param

  def initialize(type, second_param, third_param)
    @type, @second_param, @third_param = type, second_param, third_param
  end

  def to_s
    result = ""
    result << ":#{type}" unless type.nil?
    result << ", #{second_param}" unless second_param.nil?
    result << ", #{third_param}" unless third_param.nil?
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
end