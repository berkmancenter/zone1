require 'spec_helper'

describe Batch do
  it { should have_many(:stored_files) }
  it { should belong_to(:user) }
  it { should allow_mass_assignment_of :user_id }

  describe ".new_temp_batch_id" do
    it "should return non-nil" do
      Batch.new_temp_batch_id.should_not == nil
    end
  end
end
