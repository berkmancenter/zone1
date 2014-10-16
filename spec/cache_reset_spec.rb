require "spec_helper"

describe "caching in test environment" do
  it "should allow the cache to be written and read" do
    Rails.cache.write("test", "value")
    Rails.cache.exist?("test").should == true
    Rails.cache.read("test").should == "value"
  end
  it "should be reset everytime" do
    Rails.cache.exist?("test").should == false
  end
end
