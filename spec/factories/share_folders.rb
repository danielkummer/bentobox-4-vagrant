# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :share_folder do
    logical_name ""
    host_path ""
    guest_path ""
    additional_options "MyString"
  end
end
