require 'spec_helper'

describe "additional_configurations/show" do
  before(:each) do
    @additional_configuration = assign(:additional_configuration, stub_model(AdditionalConfiguration))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
