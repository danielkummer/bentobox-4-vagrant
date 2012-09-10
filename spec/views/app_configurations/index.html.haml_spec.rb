require 'spec_helper'

describe "app_configurations/index" do
  before(:each) do
    assign(:app_configurations, [
      stub_model(AppConfiguration),
      stub_model(AppConfiguration)
    ])
  end

  it "renders a list of app_configurations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
