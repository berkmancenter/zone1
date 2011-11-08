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
end
