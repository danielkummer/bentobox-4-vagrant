class HasOneValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || "is not set") if value.blank?
  end

  def self.kind() :custom end #for mongoid-rspec
end