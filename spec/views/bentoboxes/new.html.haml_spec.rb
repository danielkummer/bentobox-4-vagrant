require 'spec_helper'

describe "bentoboxes/new" do
  before(:each) do
    assign(:bentobox, stub_model(Bentobox,
      :name => "MyString",
      :description => "MyString",
      :public => false
    ).as_new_record)
  end

  it "renders new bentobox form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => bentoboxes_path, :method => "post" do
      assert_select "input#bentobox_name", :name => "bentobox[name]"
      assert_select "input#bentobox_description", :name => "bentobox[description]"
      assert_select "input#bentobox_public", :name => "bentobox[public]"
    end
  end
end
