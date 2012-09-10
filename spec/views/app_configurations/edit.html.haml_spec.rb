require 'spec_helper'

describe "app_configurations/edit" do
  before(:each) do
    @app_configuration = assign(:app_configuration, stub_model(AppConfiguration))
  end

  it "renders the edit app_configuration form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => app_configurations_path(@app_configuration), :method => "post" do
    end
  end
end
