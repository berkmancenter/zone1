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
    FactoryGirl.create(:preference)
    should validate_uniqueness_of(:name)
    should validate_uniqueness_of(:label)
  end

  it "should do fgafter_save and after_destroy caching callbacks"
  it "should auto-define class methods and pass them to find_by_name_cached"
  it "should auto-define class methods and successfully find a valid preference by name"
  

end

