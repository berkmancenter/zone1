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

  describe "#allowed_rights" do
    let(:group) { Factory(:group) }
    context "when assignable_rights == true" do
      before do
        group.should_receive(:assignable_rights).and_return(true)
      end
      it "should return self.rights" do
        group.allowed_rights.should == group.rights
      end
    end

    context "when assignable_rights == false" do
      before do
        group.should_receive(:assignable_rights).and_return(false)
      end
      it "should return []" do
        group.allowed_rights.should == []
      end
    end
  end

  describe "#members" do
    let(:user1) { Factory(:user) }
    let(:user2) { Factory(:user) }
    let(:group) { Factory(:group, :users => [user1], :owners => [user2]) }
    
    it "should return hash of users with emails as keys" do
      group.members.should == {user1.email => {:user => user1, :owner => false}, 
                               user2.email => {:user => user2, :owner => true}}
    end
  end
end
