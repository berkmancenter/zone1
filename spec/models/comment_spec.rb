require 'spec_helper'

describe Comment do
  it { should belong_to :user }
  it { should belong_to :stored_file }

  it { should validate_presence_of :user_id }
  it { should validate_presence_of :stored_file_id }
  it { should validate_presence_of :content }

  it { should allow_mass_assignment_of :content }
  it { should allow_mass_assignment_of :user_id }
  it { should allow_mass_assignment_of :stored_file_id }
  it { should allow_mass_assignment_of :created_at }
  it { should allow_mass_assignment_of :updated_at }
end
