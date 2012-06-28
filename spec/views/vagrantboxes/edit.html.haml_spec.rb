require 'spec_helper'

describe "vagrantboxes/edit" do
  before(:each) do
    @vagrantbox = assign(:vagrantbox, stub_model(Vagrantbox,
      :name => "MyString",
      :path => "MyString"
    ))
  end

  it "renders the edit vagrantbox form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => vagrantboxes_path(@vagrantbox), :method => "post" do
      assert_select "input#vagrantbox_name", :name => "vagrantbox[name]"
      assert_select "input#vagrantbox_path", :name => "vagrantbox[path]"
    end
  end
end
