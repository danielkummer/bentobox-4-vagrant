class AppConfiguration
  include Mongoid::Document
  field :name, type: String
  field :value, type: String

  validates :name, uniqueness: true
  attr_readonly :name

  def self.get(key)
    key = key.to_s
    begin
      config = where(name: key).first
      config.value
    rescue Exception
      nil
    end
  end

  def self.put(key, value)
    key = key.to_s
    config = find_or_create_by(name: key)
    config.value = value
    config.save
  end

end
