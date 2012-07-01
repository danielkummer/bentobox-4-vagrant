# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ingredient do
    name "test"
    cookbooks "test"
    share_folder "test"
    network_config ':hostonly, "33.33.33.10"'
  end
end
