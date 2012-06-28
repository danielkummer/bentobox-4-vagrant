require 'spec_helper'

describe "bentoboxes/show" do
  before(:each) do
    @bentobox = assign(:bentobox, stub_model(Bentobox,
      :name => "Name",
      :description => "Description",
      :public => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Description/)
    rendered.should match(/false/)
  end
end
