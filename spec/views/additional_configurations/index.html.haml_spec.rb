require 'spec_helper'

describe "additional_configurations/index" do
  before(:each) do
    assign(:additional_configurations, [
      stub_model(AdditionalConfiguration),
      stub_model(AdditionalConfiguration)
    ])
  end

  it "renders a list of additional_configurations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
