require 'spec_helper'

describe Group do
  before do
    FactoryGirl.create :group_invite_from_address
    @invited_user = FactoryGirl.create(:user, :email => "invited@endpoint.com")
    @user = FactoryGirl.create(:user, :email => "user@endpoint.com")
    @owner = FactoryGirl.create(:user, :email => "owner@endpoint.com")
    @group = FactoryGirl.create(:group)
    @owner_membership = Membership.add_users_to_groups [@owner], [@group], :is_owner => true
    @user_membership = Membership.add_users_to_groups [@user], [@group]
    @invited_membership = Membership.invite_users_to_groups [@invited_user], [@group]
    @group.reload
  end
  
  it { should have_many(:memberships) }
  it { should have_many(:groups_stored_files) }
  it { should have_many(:stored_files) }
  it { should have_many(:rights) }
  it { should have_many(:right_assignments) }

  it "should validate_uniqueness_of name" do
    FactoryGirl.create :group
    should validate_uniqueness_of(:name)
  end

  it { should validate_presence_of(:name) }


  describe "callbacks" do

    context "after_create" do

      before do
        @group = Group.new :name => "test"
        @group.should_receive(:destroy_cache)
      end

      it "should destroy_cache" do
        @group.save
      end
    end


    context "after_update" do

      before do 
        @group.should_receive(:destroy_cache)
      end

      it "should destroy_cache" do
        @group.update_attributes(:name => "New Name")
      end

    end


    context "after_destroy" do
      
      before do
        pending("@group.should_receive(:delete_memberships)")
        @group.should_receive(:destroy_cache)
      end
   
      it "should destroy_cache" do
        @group.destroy
      end
    end
  end #describe callbacks


  describe "#allowed_rights" do
    let(:group) { FactoryGirl.create(:group) }
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
        assert_equal [], group.allowed_rights
      end
    end
  end #describe allow rights

  describe "#cached_viewable_rights" do
    it "should return users who have rights to view a right"
  end

  describe "invite_users_by_email" do
      
    it "should create invited memberships" do
      @new_invited_user = FactoryGirl.create(:user, :email => "new_invited@endpoint.com")
      @group.invite_users_by_email([@new_invited_user.email])
      assert @group.invited_members.include?(@new_invited_user)
    end

    it "when inviting a non-existent email" do
      assert_raise RuntimeError do
        @group.invite_users_by_email(['none-existent@email address'])
      end
    end
  end #describe invite users by email

=begin
  describe "#set_owners" do
    context "when owner is an existing owner" do 
      before do
        @group.set_owners([@owner])
        @group.reload
      end
      it "should replace the current owners with new owners" do
        assert_equal [@owner], @group.owners
      end

      it "should update the users" do
        assert_equal Set.new([@invited_user, @user]), Set.new(@group.users)
      end
    end
    
    context "when owner is an existing user" do 
      before do
        @group.set_owners([@user])
        @group.reload
      end
      it "should replace the current owners with new owners" do
        assert_equal [@user], @group.owners
      end

      it "should update the users" do
        assert_equal [@invited_user], @group.users
      end
    end
    
    context "when owner is also a new user" do
      before do
        @new_owner = FactoryGirl.create(:user, :email => "new_owner@endpoint.com")
        @group.set_owners([@new_owner])
        @group.reload
      end
      it "should replace the current owners with new owners" do
        assert_equal [@new_owner], @group.owners
      end

      it "should not affect the users" do
        assert_equal Set.new([@invited_user, @user]), Set.new(@group.users)
      end
    end
  end #describe set owners

  describe "#set_users" do

    context "when user is an existing user" do 
      before do
        @group.set_users([@user])
        @group.reload
      end
      it "should not update the owners" do
        assert_equal [@owner], @group.owners
      end

      it "should update the users" do
        assert_equal [@user], @group.users
      end
    end
    context "when user is existing owner" do
      before do
        @new_owner = FactoryGirl.create(:user, :email => "new_owner@endpoint.com")
        Membership.add_users_to_groups([@new_owner], [@group], :is_owner => true) #need to add one so we can remove one
        @group.reload
        @group.set_users([@owner])
        @group.reload
      end
      it "should replace the current users with the new users" do
        assert_equal [@owner], @group.users
      end
      it "should not affect the owners" do
        assert_equal [@new_owner], @group.owners
      end
    end

    context "when user is new user" do
      before do
        @new_user = FactoryGirl.create(:user, :email => "new_user@endpoint.com")
        @group.set_users([@new_user])
        @group.reload
      end
      it "should replace the current users with the new users" do
        assert_equal [@new_user], @group.users
      end
      it "should not affect the owners" do
        assert_equal [@owner], @group.owners
      end
    end
  end #describe set users
   
  describe "#delete_members" do
    before do
      @group.delete_members([@user])
    end
    it "should delete the membership" do
      assert !@group.members.include?(@user)
    end

    context "when deleting the last owner of a group" do
      it "should raise an error" do
        assert_raise RuntimeError do
          @group.delete_members([@owner])
        end
      end
    end
  end #describe delete members

=end

  
  describe "#members" do
    it "should return all users" do
      assert_equal Set.new([@invited_user, @owner, @user]), Set.new(@group.members)
    end
  end
  
  describe "#invited_members" do
    it "should only show invited users" do
      assert_equal [@invited_user], @group.invited_members
    end
  end

  describe "#confirmed_members" do
    it "should return only confirmed users" do
      assert_equal Set.new([@user, @owner]), Set.new(@group.confirmed_members)
    end
  end

  describe "#owners" do
    it "should only show users which are owners" do
      assert_equal [@owner], @group.owners
    end
  end

  describe "#users" do
    it "should only show users which are group users" do
      assert_equal Set.new([@invited_user, @user]), Set.new(@group.users)
    end
  end
end
