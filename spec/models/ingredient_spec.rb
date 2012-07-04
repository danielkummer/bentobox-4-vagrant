require 'spec_helper'

describe Ingredient do
  it "should have a valid factory" do
    Fabricate.build(:ingredient).should be_valid
  end

  it { should have_fields :name, :cookbooks, :network_config }
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }

  it { should embed_many :portmappings }
  it { should embed_many :share_folders }
  it { should belong_to(:category).of_type(Category) }
  it { should have_and_belong_to_many :bentoboxes }

  it { should be_multiparameted_document }

end

