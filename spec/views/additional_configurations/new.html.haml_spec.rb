require 'spec_helper'

describe "additional_configurations/new" do
  before(:each) do
    assign(:additional_configuration, stub_model(AdditionalConfiguration).as_new_record)
  end

  it "renders new additional_configuration form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => additional_configurations_path, :method => "post" do
    end
  end
end
