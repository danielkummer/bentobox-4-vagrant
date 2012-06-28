require 'spec_helper'

describe "vagrantboxes/show" do
  before(:each) do
    @vagrantbox = assign(:vagrantbox, stub_model(Vagrantbox,
      :name => "Name",
      :path => "Path"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Path/)
  end
end
