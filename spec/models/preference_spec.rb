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

  it "should cache results of .find(:all) finder" do
    Rails.cache.clear
    Rails.cache.should_receive(:fetch).with("preferences")
    Preference.all
  end
  
  context "when a given preference exists" do
    before(:each) do
      Rails.cache.clear
      @pref1 = FactoryGirl.create :preference, :name => 'test_pref1', :value => 'pref_value1'
      @pref2 = FactoryGirl.create :preference, :name => 'test_pref2', :value => 'pref_value2'
    end

    it "#all should return all existing Preferences" do
      Preference.all.map(&:name).sort.should == [@pref1.name, @pref2.name].sort
    end

    it "should cache all preferences under the 'preferences' cache key" do
      Rails.cache.exist?('preferences').should == false
      Preference.all
      Rails.cache.exist?('preferences').should == true
    end
    
    it "cached_find_by_name should delegate to self.all" do 
      Preference.should_receive(:all) { [@pref1, @pref2] }
      Preference.cached_find_by_name "test_pref1"
    end
    
    it "should find it via cached_find_by_name" do
      Preference.cached_find_by_name('test_pref1').should == 'pref_value1'
    end
  end

  context "when a given preference does not exist" do
    it "should return nil with no errors" do
      Preference.cached_find_by_name('some_fake_pref').should == nil
    end
  end
end
