require 'spec_helper'

describe "bentoboxes/index" do
  before(:each) do
    assign(:bentoboxes, [
      stub_model(Bentobox,
        :name => "Name",
        :description => "Description",
        :public => false
      ),
      stub_model(Bentobox,
        :name => "Name",
        :description => "Description",
        :public => false
      )
    ])
  end

  it "renders a list of bentoboxes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
