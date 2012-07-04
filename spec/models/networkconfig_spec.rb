require 'spec_helper'

describe Networkconfig do

  it { should have_fields(:type, :second_parameter, :third_parameter).of_type(String) }
  it { should validate_presence_of :type }
  it { should validate_presence_of :second_parameter }
  it { should validate_inclusion_of(:type).to_allow("hostonly", "bridged") }
  it { should be_embedded_in(:ingredient).as_inverse_of(:networkconfig) }

  it "should return a valid networkconfig string" do
    config = Fabricate(:ingredient)
    config.networkconfig.to_s.should == ":hostonly, 123.123.123.123"
  end
end
