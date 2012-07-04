require 'spec_helper'

describe Portmapping do

  it "should have a valid factory" do
    Fabricate.build(:portmapping).should be_valid
  end

  it { should have_field(:mapping).of_type(String) }
  it { should validate_presence_of :mapping }
  it { should validate_format_of(:mapping).to_allow("80:8080").not_to_allow("65536:80") }
  it { should be_embedded_in(:ingredient).as_inverse_of(:portmappings) }
end

