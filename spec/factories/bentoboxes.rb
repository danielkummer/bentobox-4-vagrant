# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bentobox do
    name "Bentobox"
    description "Description"
    public false
    association :vagrantbox_id, :factory => :vagrantbox
    association :user_id, :factory => :user
  end
end
