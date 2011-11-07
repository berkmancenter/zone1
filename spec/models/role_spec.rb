require 'spec_helper'

describe Role do
  it "should validate uniqueness of :name" do
    FactoryGirl.create(:role)
    should validate_uniqueness_of(:name)
  end
  it { should have_many(:right_assignments) }
  it { should have_many(:rights).through(:right_assignments) }
end
