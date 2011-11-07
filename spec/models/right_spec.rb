require 'spec_helper'

describe Right do
  it { should validate_presence_of :method }
  it "should validate_uniqueness_of description" do
    FactoryGirl.create :right
    should validate_uniqueness_of :description
  end
  it { should have_many :right_assignments }
end
