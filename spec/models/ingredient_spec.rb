require 'spec_helper'

describe Ingredient do
  it "should have a valid factory" do
    FactoryGirl.build(:ingredient).should be_valid
  end

  it { should have_fields :name, :cookbooks, :share_folder, :network_config }
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }

  it { should embed_many :portmappings }
  it { should belong_to(:category).of_type(Category) }
  it { should have_and_belong_to_many :bentoboxes }

end

