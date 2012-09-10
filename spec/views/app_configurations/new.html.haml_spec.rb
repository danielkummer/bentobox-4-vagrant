require 'spec_helper'

describe "app_configurations/new" do
  before(:each) do
    assign(:app_configuration, stub_model(AppConfiguration).as_new_record)
  end

  it "renders new app_configuration form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => app_configurations_path, :method => "post" do
    end
  end
end
