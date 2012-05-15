require 'spec_helper'

describe Preference do
  it { should validate_presence_of :name }
  it { should validate_presence_of :label }
  it { should validate_presence_of :value }

  it { should allow_mass_assignment_of :name }
  it { should allow_mass_assignment_of :label }
  it { should allow_mass_assignment_of :value }

  it "should validate uniqueness of :name" do
    FactoryGirl.create(:preference)
    should validate_uniqueness_of(:name)
    should validate_uniqueness_of(:label)
  end

  it "should do after_save and after_destroy caching callbacks"
  it "should auto-define class methods and pass them to find_by_name_cached"
  it "should auto-define class methods and successfully find a valid preference by name"

  context "when a given preference exists" do
    before(:each) do
      Rails.cache.clear
      FactoryGirl.create :preference, :name => 'test_pref_name', :value => 'pref_value'
    end

    it "should not raise any error" do
      lambda { Preference.test_pref_name }.should_not raise_error(NoMethodError)
    end
    it "should find its value if we call it as a class method" do
      Preference.test_pref_name.should == 'pref_value'
    end

  end

  context "when a given preference does not exist" do
    before do
      Preference.destroy_all
    end
    it "should return nil with no errors" do
      Preference.some_fake_pref.should == nil
    end
    
  end

end

