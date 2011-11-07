require 'spec_helper'

describe ContentType do
  it { should have_many(:stored_files) }
  it "should validate uniquness of :name" do
    FactoryGirl.create :content_type 
    should validate_uniqueness_of(:name)
  end
end
