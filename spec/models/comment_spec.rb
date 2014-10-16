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

=begin
  describe "can_user_delete?" do
    let(:stored_file) { FactoryGirl.create(:stored_file) }
    let(:comment) { FactoryGirl.create(:comment) }

    context "when user param is nil" do
      it "should return false" do
        comment.can_user_delete?.should == true
      end
    end
  end
=end

end
