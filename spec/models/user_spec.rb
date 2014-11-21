require "spec_helper"

describe User do
  subject{ FactoryGirl.create(:user) }
  it { should have_many(:memberships).dependent(:destroy) }
  it { should have_many :groups }
  it { should have_and_belong_to_many :roles }
  it { should have_many(:sftp_users).dependent(:destroy) }
  it { should have_many :batches }
  it { should have_many :comments }
  it { should have_many :stored_files }
  it { should have_many :right_assignments }
  it { should have_many :rights }
  
  it { should allow_mass_assignment_of :email }
  it { should allow_mass_assignment_of :password }
  it { should allow_mass_assignment_of :password_confirmation }
  it { should allow_mass_assignment_of :remember_me }
  it { should allow_mass_assignment_of :name }
  it { should allow_mass_assignment_of :quota_used }
  it { should allow_mass_assignment_of :quota_max }
  it { should allow_mass_assignment_of :role_ids }
  it { should allow_mass_assignment_of :right_ids }

  it { should validate_presence_of :name }

  describe "#can_flag?(flag)" do
    let(:user) { FactoryGirl.create(:user) }
    let(:flag) { FactoryGirl.create(:flag) }
    it "should check global_method" do
      user.should_receive("can_do_global_method?").with("add_#{flag.name.downcase}")
      user.can_flag?(flag)
    end
  end

  describe "#can_unflag?(flag)" do
    let(:user) { FactoryGirl.create(:user) }
    let(:flag) { FactoryGirl.create(:flag) }
    it "should check global_method" do
      user.should_receive("can_do_global_method?").with("remove_#{flag.name.downcase}")
      user.can_unflag?(flag)
    end
  end

  describe "#can_do_global_method?(method)" do
    let(:user) { FactoryGirl.create(:user) }
    context "when user can do method" do
      it "should return true" do
        user.should_receive(:all_rights).and_return([:test_method])
        user.can_do_global_method?(:test_method).should == true
      end
    end
    context "when user can't do method" do
      it "should return false" do
        user.should_receive(:all_rights).and_return([])
        user.can_do_global_method?(:test_method).should == false
      end
    end
  end

  describe "#can_set_access_level?(stored_file, access_level)" do
    let(:user) { FactoryGirl.create(:user) }
    let(:stored_file) { FactoryGirl.create(:stored_file) }
    let(:access_level) { FactoryGirl.create(:access_level) }
    it "should check can_do_method?" do
      user.should_receive("can_do_method?").with(stored_file, "toggle_#{access_level.name}")
      user.can_set_access_level?(stored_file, access_level)
    end
  end

  describe "#quota_used" do
    let(:user) { FactoryGirl.create(:user) }
    context "when not defined" do
      it "should return 0" do
        user.quota_used.should == 0
      end
    end
    context "when defined" do
      let (:user) { FactoryGirl.create(:user, :quota_used => 1000) }
      it "should read_attribute" do
        user.should_receive(:read_attribute).with(:quota_used)
        user.quota_used
      end
    end
  end

  describe "#quota_max" do
    let(:user) { FactoryGirl.create(:user) }
    context "when not defined" do
      it "should return default_quota_max" do
        user.should_receive(:default_quota_max)
        user.quota_max
      end
    end
    context "when defined" do
      let(:user) { FactoryGirl.create(:user, :quota_max => 1000) }
      it "should read_attribute" do
        user.should_receive(:read_attribute).with(:quota_max)
        user.quota_max
      end
    end
  end

  describe "#default_quota_max" do
    let(:user) { FactoryGirl.create(:user) }

    it "should lookup the Preference" do
      #because we're using cached when "value" is called, it seems the cache is hit again!
      Preference.should_receive(:cached_find_by_name).with("default_user_upload_quota").twice
      user.default_quota_max
    end

    context "when the Preference is not defined" do
      it "should return 0" do
        user.default_quota_max.should == 0
      end
    end
  end

  describe "#quota_max=" do
    let(:user) { FactoryGirl.create(:user) }
    context "when equal to default_quota_amount" do
      it "should set the attribute to nil" do
        user.should_receive(:write_attribute).with(:quota_max, nil)
        user.quota_max=0
      end
    end
    context "when not equal to default_quota_amount" do
      it "should set the attribute to the amount" do
        user.should_receive(:write_attribute).with(:quota_max, 1000)
        user.quota_max=1000
      end
    end
  end

  describe "#decrease_available_quota!(amount)" do
    let(:user) { FactoryGirl.create(:user, :quota_used => 1000) }
    it "should increase quota_used by the amount" do
      user.should_receive(:increment!).with(:quota_used, 500)
      user.decrease_available_quota!(500)
    end
  end

  describe "#increase_available_quota!(amount)" do
    let(:user) { FactoryGirl.create(:user, :quota_used => 100) }
    context "if quota_will_be_zeroed" do
      it "should update quota_used to 0" do
        user.should_receive(:update_column).with(:quota_used, 0)
        user.increase_available_quota!(101)
      end
    end
    context "if quota won't be zeroed" do
      it "should subtract the approprate amount from quota_used" do
        user.should_receive(:update_column).with(:quota_used, 1)
        user.increase_available_quota!(99)
      end
    end
  end

  describe "#percent_quota_available" do
    let(:user) { FactoryGirl.create(:user, :quota_used => 100, :quota_max => 100) }
    it "should return percentage as a float" do
      user.percent_quota_available.should == 100
      user.percent_quota_available.is_a?(Float).should == true
    end
  end

  describe "#role_rights" do
    let(:user) { FactoryGirl.create(:user) }
    let(:role) { FactoryGirl.create(:role) }
    let(:right) { FactoryGirl.create(:right, :action => "be_awesome") }
    let(:right2) { FactoryGirl.create(:right, :action => "be_radical") }
    let(:rights) { ["be_awesome", "be_radical"] }

    context "when user has role and role has rights" do
      before(:each) do
        user.roles << role
        role.rights = [right, right2]
      end
      it "user role_rights should map to rights" do
        user.role_rights.all? { |n| rights.include?(n) }.should == true
      end
    end
  end

  describe "#all_rights" do
    let(:user) { FactoryGirl.create(:user, :email => "test1@email.com") }
    let(:role) { FactoryGirl.create(:role) }
    let(:right) { FactoryGirl.create(:right, :action => "be_awesome") }
    let(:right2) { FactoryGirl.create(:right, :action => "be_radical") }
    let(:right3) { FactoryGirl.create(:right, :action => "be_cool") }
    let(:right4) { FactoryGirl.create(:right, :action => "be_tubular") }
    let(:rights) { ["be_awesome", "be_radical", "be_cool", "be_tubular"] }

    context "when user has role and role has rights" do
      before(:each) do
        user.roles << role
        role.rights = [right, right2]
        user.rights = [right3, right4]
      end
      it "user role_rights should map to rights" do
        user.all_rights.all? { |n| rights.include?(n) }.should == true
      end
    end
  end

  describe "#can_do_method?" do
    let(:user1) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }
    let(:user3) { FactoryGirl.create(:user) }
    let(:stored_file) { FactoryGirl.create(:stored_file, :user_id => user2.id) }
    let(:global_right) { FactoryGirl.create(:right, :action => "some_global_right") }
    let(:owned_right) { FactoryGirl.create(:right, :action => "some_right_on_owned") }

    context "when user has global right" do
      before(:each) do
        user1.rights << global_right
      end
      it "should be allowed to do global right" do
        user1.can_do_method?(stored_file, "some_global_right").should == true
      end
      it "should not be allowed to do owned right" do
        user1.can_do_method?(stored_file, "some_right").should == false
      end
    end

    context "when user has ownership" do
      before(:each) do
        user2.rights << owned_right
      end
      it "should not be allowed to do global right" do
        user2.can_do_method?(stored_file, "some_global_right").should == false 
      end
      it "should be allowed to do owned right" do
        user2.can_do_method?(stored_file, "some_right").should == true
      end
    end

    context "when user does not own file or have global right" do
      it "should not be allowed to do global right" do
        user3.can_do_method?(stored_file, "some_global_right").should == false 
      end
      it "should be allowed to do owned right" do
        user3.can_do_method?(stored_file, "some_right").should == false 
      end
    end
  end

  describe "#can_do_group_method?" do
    let(:user1) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }
    let(:user3) { FactoryGirl.create(:user) }
    let(:global_right) { FactoryGirl.create(:right, :action => "some_global_right") }
    let(:owned_right) { FactoryGirl.create(:right, :action => "some_right_on_owned") }
    let(:group) do
      group = FactoryGirl.create(:group, :name => "Test Group")
      Membership.add_users_to_groups([user2], [group], :is_owner => true)
      group
    end

    context "when user has global right" do
      before(:each) do
        user1.rights << global_right
      end
      it "should be allowed to do global right" do
        user1.can_do_group_method?(group, "some_global_right").should == true
      end
      it "should not be allowed to do owned right" do
        user1.can_do_group_method?(group, "some_right").should == false
      end
    end

    context "when user has ownership" do
      before(:each) do
        user2.rights << owned_right
      end
      it "should not be allowed to do global right" do
        user2.can_do_group_method?(group, "some_global_right").should == false 
      end
      it "should be allowed to do owned right" do
        user2.can_do_group_method?(group, "some_right").should == true
      end
    end

    context "when user does not own file or have global right" do
      it "should not be allowed to do global right" do
        user3.can_do_group_method?(group, "some_global_right").should == false 
      end
      it "should be allowed to do owned right" do
        user3.can_do_group_method?(group, "some_right").should == false 
      end
    end
  end

  describe ".cached_viewable_users" do
    let(:user1) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }
    let(:user3) { FactoryGirl.create(:user) }
    let(:right) { FactoryGirl.create(:right, :action => "some_right") }

    before(:each) do
      user1.rights << right
      user2.rights << right
      users = User.cached_viewable_users("some_right")
    end

    context "method call on flushed cache" do
      it "cache should exist" do
        Rails.cache.exist?("users-viewable-users-some_right").should == true 
      end
      it "cache should include correct users" do
        Rails.cache.fetch("users-viewable-users-some_right").include?(user1.id).should == true
        Rails.cache.fetch("users-viewable-users-some_right").include?(user2.id).should == true
      end
    end

    context "user update" do
      it "cache should not exist" do
        users = User.cached_viewable_users("some_right")
        Rails.cache.exist?("users-viewable-users-some_right").should == true
      end
      it "cache should not exist" do
        users = User.cached_viewable_users("some_right")
        user1.update_attributes(:name => "Stephie")
        Rails.cache.exist?("users-viewable-users-some_right").should == false
      end
    end
  end

  describe "#can_view_cached?" do
    let(:user1) { FactoryGirl.create(:user) } #owner
    let(:user2) { FactoryGirl.create(:user) } #not owner, no rights
    let(:user3) { FactoryGirl.create(:user) } #right via group
    let(:user4) { FactoryGirl.create(:user) } #right via role
    let(:user5) { FactoryGirl.create(:user) } #right via direct
    let(:view_right) { FactoryGirl.create(:right, :action => "view_items") }
    let(:group1) { FactoryGirl.create(:group, :assignable_rights => true) }
    let(:role1) { FactoryGirl.create(:role) }
    let(:access_level) { FactoryGirl.create(:access_level)}
    let(:stored_file) { FactoryGirl.create(:stored_file, :user_id => user1.id, :access_level => access_level) }

    before(:each) do
      group1.rights << view_right
      Membership.add_users_to_groups([user3], [group1])

      role1.rights << view_right
      user4.roles << role1
      user5.rights << view_right 
    end

    context "view items access" do
      it "stored file owner should allow view" do
        user1.can_view_cached?(stored_file.id).should == true
      end
      it "random user should not allow view" do
        user2.can_view_cached?(stored_file.id).should == false
      end
      it "user in group with view_items right should allow view" do
        user3.can_view_cached?(stored_file.id).should == true
      end
      it "user with role with view_items right should allow view" do
        user4.can_view_cached?(stored_file.id).should == true
      end
      it "user with view_items right should allow view" do
        user5.can_view_cached?(stored_file.id).should == true
      end
    end

=begin

    context "view items right via role" do
      before(:each) do
        role1.rights << admin_right
        user1.roles << role1
        user2.roles << role2
      end
      it "user with role with admin right should be admin" do
        user1.is_admin?.should == true
      end
      it "user with role without admin right should not be admin" do
        user2.is_admin?.should == false
      end
    end
    
    context "view items right via user" do
      before(:each) do
        user1.rights << admin_right
      end
      it "user with admin right should be admin" do
        user1.is_admin?.should == true
      end
      it "user without admin right should not be admin" do
        user2.is_admin?.should == false
      end
    end
=end

  end

  describe "#group_rights" do
    let(:user1) { FactoryGirl.create(:user) }
    let(:group1) { FactoryGirl.create(:group, :assignable_rights => true) }
    let(:group2) { FactoryGirl.create(:group, :assignable_rights => true) }
    let(:right1) { FactoryGirl.create(:right) }
    let(:right2) { FactoryGirl.create(:right) }
    let(:right_actions) { [right1.action, right2.action] }

    before(:each) do
      Membership.add_users_to_groups([user1], [group1, group2])
      group1.rights << right1
      group2.rights << right2
    end

    context "user with two groups" do
      it "should aggregate group rights for user" do
        user1.group_rights.should == right_actions
      end
    end
  end

  describe "#all_groups" do
    before do
      @user = FactoryGirl.create(:user)
    end
    context "when user can edit_groups" do
      before do
        @user.should_receive(:all_rights).and_return(["edit_groups"])
      end
      it "should return All Groups" do
        Group.should_receive(:all)
        @user.all_groups
      end
    end

    context "when user can't edit_Groups" do
      before do
        @user.should_receive(:all_rights).and_return([])
      end
      it "should return owned and member groups, without dups" do
        @user.should_receive(:owned_groups).and_return(["owned_group","dup_group"])
        @user.should_receive(:groups).and_return(["member_group","dup_group"])
        @user.all_groups.should == %w(owned_group dup_group member_group)
      end
    end
  end

  describe 'with admin role' do
    let(:admin_user) { FactoryGirl.create(:user) }
    let(:admin_role) { FactoryGirl.create(:role, name: 'admin') }
    before do
      admin_user.roles << admin_role
    end

    it 'can toggle user roles' do
      pending
    end

    it 'can`t toggle other admins admin role' do
      pending
    end
  end

  describe 'without admin role' do
    let(:user) { FactoryGirl.create(:user) }
    let(:user_role) { FactoryGirl.create(:role, name: 'user') }
    before do
      user.roles << user_role
    end
    it 'can`t toggle roles' do
      pending
    end
  end
end
