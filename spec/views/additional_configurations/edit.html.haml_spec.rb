require 'spec_helper'

describe "additional_configurations/edit" do
  before(:each) do
    @additional_configuration = assign(:additional_configuration, stub_model(AdditionalConfiguration))
  end

  it "renders the edit additional_configuration form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => additional_configurations_path(@additional_configuration), :method => "post" do
    end
  end
end
