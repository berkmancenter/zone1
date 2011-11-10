require File.expand_path("#{File.dirname(__FILE__)}/../spec_helper")

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
