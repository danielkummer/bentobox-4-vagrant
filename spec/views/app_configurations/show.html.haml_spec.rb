require 'spec_helper'

describe "app_configurations/show" do
  before(:each) do
    @app_configuration = assign(:app_configuration, stub_model(AppConfiguration))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
