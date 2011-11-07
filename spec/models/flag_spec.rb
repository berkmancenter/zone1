require 'spec_helper'

describe Flag do
  it "should validate uniqueness of :name" do
    FactoryGirl.create(:flag)
    should validate_uniqueness_of(:name)
  end
end
