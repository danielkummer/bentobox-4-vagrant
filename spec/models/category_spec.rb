require 'spec_helper'

describe Category do
  it "should have a valid factory" do
    Fabricate.build(:category).should be_valid
  end

  it { should have_many :ingredients }
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
end
