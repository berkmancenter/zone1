require 'spec_helper'

describe Batch do
  it { should have_many(:stored_files) }
  it { should belong_to(:user) }
  it { should allow_mass_assignment_of :user_id }
end
