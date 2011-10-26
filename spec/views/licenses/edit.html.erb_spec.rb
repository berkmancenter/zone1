require 'spec_helper'

describe "licenses/edit.html.erb" do
  before(:each) do
    @license = assign(:license, stub_model(License,
      :name => "MyString"
    ))
  end

  it "renders the edit license form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => licenses_path(@license), :method => "post" do
      assert_select "input#license_name", :name => "license[name]"
    end
  end
end
