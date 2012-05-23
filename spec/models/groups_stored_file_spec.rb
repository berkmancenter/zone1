require 'spec_helper'

describe GroupsStoredFile do

  it { should belong_to(:stored_file) }
  it { should belong_to(:group) }

  it "should validate presence of :group" do
    FactoryGirl.create(:groups_stored_file)
    should validate_presence_of :group
  end

  it { should allow_mass_assignment_of :checked }
  it { should allow_mass_assignment_of :stored_file_id }
  it { should allow_mass_assignment_of :group_id }

  pending("Refactor checked= and checked? Flagging/GroupsStoredFile methods into helper and unit test them there")

end
