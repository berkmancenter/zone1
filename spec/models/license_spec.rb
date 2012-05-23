require 'spec_helper'

describe License do
  it { should have_many :stored_files }
  it { should allow_mass_assignment_of :name }

  describe "licenses cache"  do
    let(:license) { FactoryGirl.create(:license)}

    before do
      License.all
      assert Rails.cache.exist?("licenses")
    end

    after do
      assert !Rails.cache.exist?("licenses")
    end
    
    it "should be destroyed after_update" do
      license.update_attribute(:name, "asdf")
    end

    it "should be destroyed after_create" do
      FactoryGirl.create(:license)
    end

    it "should be destroyed after_destroyed" do
      license.destroy
    end
    
  end

end
