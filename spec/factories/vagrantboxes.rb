# Read about factories at https://github.com/thoughtbot/factory_girl
include ActionDispatch::TestProcess


FactoryGirl.define do
  factory :vagrantbox do
    id
    name "MyVagrantbox"
    box  { File.open(File.join(Rails.root, 'spec', 'support', 'files', 'example.box')) }
  end
end
