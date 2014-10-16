require 'spec_helper'

describe Flag do

  it { should have_many(:flaggings) }

  it "should validate uniqueness of :name" do
    FactoryGirl.create(:flag)
    should validate_uniqueness_of(:name)
  end

  it "should validate presence of :name and :label" do
    FactoryGirl.create(:flag)
    should validate_presence_of :name
    should validate_presence_of :label
  end

  it { should allow_mass_assignment_of :name }
  it { should allow_mass_assignment_of :label }

  
  describe "flags cache"  do
    let(:flag) { FactoryGirl.create(:flag)}

    before do
      Flag.all
      assert Rails.cache.exist?("flags")
    end

    after do
      assert !Rails.cache.exist?("flags")
    end
    
    it "should be destroyed after_update" do
      flag.update_column(:name, flag.name + "asdf")
    end

    it "should be destroyed after_create" do
      FactoryGirl.create(:flag)
    end

    it "should be destroyed after_destroyed" do
      flag.destroy
    end

  end

  #reindex_flagged_stored_files
  describe "#reindex_flagged_stored_files callback" do
    it "should fire before_destroy" do
      flag = FactoryGirl.create(:flag)
      flag.should_receive(:reindex_flagged_stored_files)
      flag.destroy
    end
  end

end
