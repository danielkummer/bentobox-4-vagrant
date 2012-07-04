class HasOneValidator < ActiveModel::Validator
  def validate(record)
    record.errors[attribute] << (options[:message] || "is not set") unless value.nil?
  end

  def self.kind() :custom end #for mongoid-rspec
end