# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bentobox do
    name "MyBentobox"
    description "MyString"
    public false
    association :vagrantbox_id, :factory => :vagrantbox

  end
end
