require 'spec_helper'

describe AccessLevel do
  before(:each) do
    access_level = FactoryGirl.create(:access_level)
  end

  it { should have_many(:stored_files) }
  it { should validate_uniqueness_of(:name) }
end
