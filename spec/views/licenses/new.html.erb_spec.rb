require 'spec_helper'

describe "licenses/new.html.erb" do
  before(:each) do
    assign(:license, stub_model(License,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new license form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => licenses_path, :method => "post" do
      assert_select "input#license_name", :name => "license[name]"
    end
  end
end
