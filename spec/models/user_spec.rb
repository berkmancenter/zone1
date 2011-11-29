require "spec_helper"

describe User do
  it { should have_and_belong_to_many :groups }
  it { should have_and_belong_to_many :roles }
  it { should have_and_belong_to_many :owned_groups }
  it { should have_one :sftp_user }
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

  describe "#quota_used" do
    let(:user) { Factory(:user) }
    context "when not defined" do
      it "should return 0" do
        user.quota_used.should == 0
      end
    end
    context "when defined" do
      let (:user) { Factory(:user, :quota_used => 1000) }
      it "should read_attribute" do
        user.should_receive(:read_attribute).with(:quota_used)
        user.quota_used
      end
    end
  end

  describe "#quota_max" do
    let(:user) { Factory(:user) }
    context "when not defined" do
      it "should return default_quota_max" do
        user.should_receive(:default_quota_max)
        user.quota_max
      end
    end
    context "when defined" do
      let(:user) { Factory(:user, :quota_max => 1000) }
      it "should read_attribute" do
        user.should_receive(:read_attribute).with(:quota_max)
        user.quota_max
      end
    end
  end

  describe "#default_quota_max" do
    let(:user) { Factory(:user) }
    context "when the Preference is defined" do
      before do
        Preference.create(:name => "Default User Upload Quota", :value => "1000")
      end
      it "should lookup the Preference" do
        Preference.should_receive(:find_by_name_cached).with("Default User Upload Quota").twice #because we're using cached
                                                                                                #when "value" is called, it seems
                                                                                                #it seems the cache is hit again!
        user.default_quota_max
      end
      it "should return the value specified in the Preference as an integer" do
        user.default_quota_max.should == 1000
      end
    end
    context "when the Prefernce is not defined" do
      it "should return 0" do
        user.default_quota_max.should == 0
      end
    end
  end

  describe "#quota_max=" do
    let(:user) { Factory(:user) }
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
    let(:user) { Factory(:user, :quota_used => 1000) }
    it "should increase quota_used by the amount" do
      user.should_receive(:update_attribute).with(:quota_used, 2000)
      user.decrease_available_quota!(1000)
    end
  end

  describe "#increase_available_quota!(amount)" do
    let(:user) { Factory(:user, :quota_used => 100) }
    context "if quota_will_be_zeroed" do
      it "should update quota_used to 0" do
        user.should_receive(:update_attribute).with(:quota_used, 0)
        user.increase_available_quota!(101)
      end
    end
    context "if quota won't be zeroed" do
      it "should subtract the approprate amount from quota_used" do
        user.should_receive(:update_attribute).with(:quota_used, 1)
        user.increase_available_quota!(99)
      end
    end
  end

  describe "#quota_exceeded?" do
    context "when quota used > quota max" do
      let(:user) { Factory(:user, :quota_used => 101, :quota_max => 100) }
      it "should return true" do
        user.quota_exceeded?.should == true
      end
    end

    context "when quota used = quota max" do
      let(:user) { Factory(:user, :quota_used => 100, :quota_max => 100) }
      it "should return true" do
        user.quota_exceeded?.should == true
      end
    end

    context "when quota used < quota max" do
      let(:user) { Factory(:user, :quota_used => 99, :quota_max => 100) }
      it "should return false" do
        user.quota_exceeded?.should == false
      end
    end
  end

  describe "#percent_quota_available" do
    let(:user) { Factory(:user, :quota_used => 100, :quota_max => 100) }
    it "should return percentage as a float" do
      user.percent_quota_available.should == 100
      user.percent_quota_available.is_a?(Float).should == true
    end
  end

  describe "#quota_available?(amount)" do
    let(:user) { Factory(:user, :quota_used => 0, :quota_max => 100) }
    context "when quota is available" do
      it "should return true" do
        user.quota_available?(10).should == true
      end
    end
    context "when quota is not available" do
      it "should return false" do
        user.quota_available?(1000).should == false
      end
    end
  end

  describe "#will_quota_be_zeroed?(amount)" do
    let(:user) { Factory(:user, :quota_used => 100) }
    context "when it will be zeroed" do
      it "should return true" do
        user.will_quota_be_zeroed?(1000).should == true
      end
    end
    context "when it will not be zeored" do
      it "should return false" do
        user.will_quota_be_zeroed?(1).should == false
      end
    end
  end

  describe "#role_rights" do
    let(:user) { Factory(:user, :email => "test1@email.com") }
    let(:role) { Factory(:role) }
    let(:right) { Factory(:right, :action => "be_awesome") }
    let(:right2) { Factory(:right, :action => "be_radical") }
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
    let(:user) { Factory(:user, :email => "test1@email.com") }
    let(:role) { Factory(:role) }
    let(:right) { Factory(:right, :action => "be_awesome") }
    let(:right2) { Factory(:right, :action => "be_radical") }
    let(:right3) { Factory(:right, :action => "be_cool") }
    let(:right4) { Factory(:right, :action => "be_tubular") }
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
end
