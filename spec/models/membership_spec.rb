require 'spec_helper'

describe Membership do
  it { should belong_to(:user) }
  it { should belong_to(:group) }

  it { should allow_mass_assignment_of :user }
  it { should allow_mass_assignment_of :group }
  it { should allow_mass_assignment_of :user_id }
  it { should allow_mass_assignment_of :group_id }
  it { should allow_mass_assignment_of :is_owner }
  it { should allow_mass_assignment_of :joined_at }
  it { should allow_mass_assignment_of :invited_by }

  before do
    @user = FactoryGirl.create(:user, :email => "user@endpoint.com")
    @owner = FactoryGirl.create(:user, :email => "owner@endpoint.com")
    @group = FactoryGirl.create(:group)
    @membership = Membership.add_users_to_groups([@owner], [@group], :is_owner => true).first
  end
  
  describe "callbacks" do
    context "after_create" do
      before do
        @membership = Membership.new(:user => @user, :group => @group, :joined_at => Time.now)
        @membership.should_receive(:destroy_cache)
      end
      it "should destroy_cache" do
        @membership.save
      end
    end
    context "after_update" do
      before do 
        @membership.should_receive(:destroy_cache)
      end
      it "should destroy_cache" do
        @membership.update_attributes(:is_owner => true)
      end
    end
    context "after_destroy" do
      before do
        Membership.add_users_to_groups([FactoryGirl.create(:user)], [@group], :is_owner => true)  # must add a new owner to destroy
        @membership.should_receive(:destroy_cache)
      end
      it "should destroy_cache" do
        @membership.destroy
      end
    end
  end
  
  describe ".invite_users_to_groups" do
    context "when adding a regular user" do
      before do
        @new_memberships = Membership.invite_users_to_groups [@user], [@group]
      end
      it "should return an array of the new memberships" do
        assert_equal [Membership.last], @new_memberships
      end
      it "should create invited_members for the group" do
        assert_equal Set.new([@user]), Set.new(@group.invited_members)
      end
    end
  end

  describe ".add_users_to_groups" do
    context "when adding a regular user" do
      before do
        @new_memberships = Membership.add_users_to_groups [@user], [@group]
      end
      it "should return an array of the new memberships" do
        assert_equal [Membership.last], @new_memberships
      end
      it "should create confirmed_members for the group" do
        assert_equal Set.new([@owner, @user]), Set.new(@group.confirmed_members)
      end
    end

    context "when adding an owner" do
      before do
        @new_owner = FactoryGirl.create(:user, :email => "new_owner@endpoint.com")
        @owner_memberships = Membership.add_users_to_groups [@new_owner], [@group], :is_owner => true
      end
      it "should add an owner" do
        assert_equal Set.new([@owner, @new_owner]), Set.new(@group.owners)
      end
    end
  end

  describe "validate group_has_owner" do
    # this is covered in the group_spec
  end

  describe "validate uniqueness_of_user" do
    before do
      Membership.add_users_to_groups [@user], [@group]
    end
    it "should raise an error if the same user is invited again" do
      assert_raise RuntimeError do
        Membership.invite_users_to_groups [@user], [@group]
      end
    end
    it "should raise an error if the same user is added again" do
      assert_raise RuntimeError do
        Membership.add_users_to_groups [@user], [@group]
      end
    end
  end
end
