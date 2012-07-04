require 'spec_helper'

describe ShareFolder do

  it "should have a valid factory" do
    Fabricate.build(:share_folder).should be_valid
  end

  it { should have_fields(:logical_name, :host_path, :guest_path, :additional_options) }
  it { should validate_presence_of :logical_name }
  it { should validate_presence_of :host_path }
  it { should validate_presence_of :guest_path }
  it { should validate_uniqueness_of :logical_name }

end
