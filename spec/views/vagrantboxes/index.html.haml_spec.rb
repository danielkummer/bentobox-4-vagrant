require 'spec_helper'

describe "vagrantboxes/index" do
  before(:each) do
    assign(:vagrantboxes, [
      stub_model(Vagrantbox,
        :name => "Name",
        :path => "Path"
      ),
      stub_model(Vagrantbox,
        :name => "Name",
        :path => "Path"
      )
    ])
  end

  it "renders a list of vagrantboxes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Path".to_s, :count => 2
  end
end
