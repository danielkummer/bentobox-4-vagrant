require 'spec_helper'

describe AdditionalConfiguration do
  it "should have a valid factory" do
    Fabricate.build(:additional_configuation).should be_valid
  end

  it { should have_field(:value).of_type(String) }
  it { should have_field(:name).of_type(String) }
  it { should validate_presence_of :value }
  it { should validate_presence_of :name }
  it { should validate_format_of(:value).to_allow("config.ok").not_to_allow("screwedconfig") }
  it { should be_embedded_in(:bentobox).as_inverse_of(:additional_configuations) }

end
