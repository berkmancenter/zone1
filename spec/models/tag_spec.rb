require 'spec_helper'

describe Tag do

  before(:each) do
    Rails.cache.clear
  end

  it "should cache results of Tag.tag_list" do
    Tag.tag_list
    Rails.cache.exist?("tag-list").should == true
  end

end
