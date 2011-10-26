require 'spec_helper'

describe "licenses/index.html.erb" do
  before(:each) do
    assign(:licenses, [
      stub_model(License,
        :name => "Name"
      ),
      stub_model(License,
        :name => "Name"
      )
    ])
  end

  it "renders a list of licenses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
