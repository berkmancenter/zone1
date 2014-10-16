require 'spec_helper'

describe Flagging do
  it { should belong_to :flag }
  it { should belong_to :stored_file }
  it { should belong_to :user }

  it { should validate_presence_of :flag_id }
  it { should validate_presence_of :user_id }

  it { should allow_mass_assignment_of :flag_id }
  it { should allow_mass_assignment_of :user_id }
  it { should allow_mass_assignment_of :stored_file_id }
  it { should allow_mass_assignment_of :note }
  it { should allow_mass_assignment_of :checked }
  
  context "when flagging is new record" do
    subject { Flagging.new }
    it { should_not validate_presence_of :stored_file_id }
  end

  context "when flagging is existing record" do
    subject { FactoryGirl.create(:flagging) }
    it { should validate_presence_of :stored_file_id }
  end

  describe "#checked=" do
    context "when called an existing record" do
      subject { FactoryGirl.create(:flagging) }
      it { should raise_error }
    end
    context "when passed false" do
      before { subject.checked=false }
      it "should return false" do 
        subject.checked == false
      end
    end
    context "when passed true" do
      before { subject.checked=true }
      it "should return true" do 
        subject.checked.should == true
      end
    end
  end

  describe "#checked?" do
    context "when a new record" do
      subject { Flagging.new}
      it "should return true" do
        subject.checked? == true
      end
    end
    context "when an existing record" do
      subject { FactoryGirl.create(:flagging) }
      it "should return false" do
        subject.checked? == false
      end
    end
  end
end
