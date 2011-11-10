require 'spec_helper'

describe Group do
  it { should have_and_belong_to_many(:owners) }
  it { should have_and_belong_to_many(:users) }
  it { should have_many(:groups_stored_files) }
  it { should have_many(:stored_files) }

  it "should validate_uniqueness_of name" do
    FactoryGirl.create :group
    should validate_uniqueness_of :name
  end
end
