require 'spec_helper'

describe StoredFile do
  it { should belong_to :license }
  it { should belong_to :user }
  it { should belong_to :content_type }
  it { should belong_to :access_level }
  it { should belong_to :batch }
  it { should have_many :comments }
  it { should have_many :flaggings }
  it { should have_many :flags }
  it { should have_and_belong_to_many :groups }
  it { should have_one :disposition }

  it { should accept_nested_attributes_for :flaggings }
  it { should accept_nested_attributes_for :disposition }

  it { should allow_mass_assignment_of :file }
  it { should allow_mass_assignment_of :license_id }
  it { should allow_mass_assignment_of :collection_name }
  it { should allow_mass_assignment_of :author }
  it { should allow_mass_assignment_of :title }
  it { should allow_mass_assignment_of :copyright }
  it { should allow_mass_assignment_of :description }
  it { should allow_mass_assignment_of :access_level_id }
  it { should allow_mass_assignment_of :user_id }
  it { should allow_mass_assignment_of :content_type_id }
  it { should allow_mass_assignment_of :original_filename }
  it { should allow_mass_assignment_of :batch_id }
  it { should allow_mass_assignment_of :allow_notes }
  it { should allow_mass_assignment_of :delete_flag }
  it { should allow_mass_assignment_of :office }
  it { should allow_mass_assignment_of :tag_list }
  it { should allow_mass_assignment_of :publication_type_list }
  it { should allow_mass_assignment_of :collection_list }
  it { should allow_mass_assignment_of :disposition }
  it { should allow_mass_assignment_of :group_ids }
  it { should allow_mass_assignment_of :flaggings_attributes }
  it { should allow_mass_assignment_of :disposition_attributes }
  it { should allow_mass_assignment_of :allow_tags }

  # Examples of double / stub
  #stored_file = double("stored_file")
  #stored_file.stub(:flags).and_return([flag])
  #flag = Factory(:flag)
  #Flag.stub!(:preserved).and_return([flag])
  #FlagClass = doubleflag.stub(:name).and_return(Flag.PRESERVED_NAMES.first) # set name to PRESERVED

  describe "#has_preserved_flag?" do
    let(:stored_file) { Factory(:stored_file) }
    let(:user) { Factory(:user) }

    context "when stored file has a preserved flag" do
      before(:each) do
        flag = Flag.preserved.first
        flagging = Factory(:flagging, :flag_id => flag.id, :user_id => user.id, :stored_file_id => stored_file.id)
      end
      it "should return true" do
        stored_file.has_preserved_flag?.should == true
      end
    end
    context "when stored file does not have a preserved flag" do
      before(:each) do
        flag = (Flag.all - Flag.preserved).first
        flagging = Factory(:flagging, :flag_id => flag.id, :user_id => user.id, :stored_file_id => stored_file.id)
      end
      it "should return false" do
        stored_file.has_preserved_flag?.should == false
      end
    end
  end

  describe "#has_preserved_or_record_flag?" do
    let(:stored_file) { Factory(:stored_file) }
    let(:user) { Factory(:user) }

    context "when stored file has a selected flag" do
      before(:each) do
        flag = Flag.selected.first
        flagging = Factory(:flagging, :flag_id => flag.id, :user_id => user.id, :stored_file_id => stored_file.id)
      end
      it "should return true" do
        stored_file.has_preserved_or_record_flag?.should == true
      end
    end
    context "when stored file does not have a selected flag" do
      before(:each) do
        flag = (Flag.all - Flag.selected).first
        flagging = Factory(:flagging, :flag_id => flag.id, :user_id => user.id, :stored_file_id => stored_file.id)
      end
      it "should return false" do
        stored_file.has_preserved_or_record_flag?.should == false
      end
    end
  end


  describe "#update_tags" do
    let(:stored_file) { Factory(:stored_file) }
    let(:new_tags) { ["test1", "test2"] }
    let(:new_tags2) { ["test3", "test4"] }
    let(:new_tags3) { ["test2", "test3"] }
    let(:user) { Factory(:user, :email => "test1@email.com") }
    let(:user2) { Factory(:user, :email => "test2@email.com") }

    context "when new tags are introduced" do
      before(:each) do
        stored_file.update_tags(new_tags.join(', '), :tags, user)
      end

      it "tags should be added" do
        stored_file.owner_tags_on(nil, :tags).collect { |t| t.name }.all? { |n| new_tags.include?(n) }.should == true
      end
      it "tags should be owned by user" do
        stored_file.owner_tags_on(user, :tags).collect { |t| t.name }.all? { |n| new_tags.include?(n) }.should == true
      end
    end

    context "when tags are removed" do
      before(:each) do
        stored_file.update_tags(new_tags.join(', '), :tags, user)
        stored_file.update_tags(new_tags2.join(', '), :tags, user2)
      end

      it "tags should be removed" do
        stored_file.owner_tags_on(nil, :tags).collect { |t| t.name }.all? { |n| new_tags2.include?(n) }.should == true
      end
    end

    context "when a new tag is added and an old tag is removed" do
      before(:each) do
        stored_file.update_tags(new_tags.join(', '), :tags, user)
        stored_file.update_tags(new_tags3.join(', '), :tags, user2)
      end

      it "tags should reflect the new tags" do # TODO: Beats me on how to name this
        stored_file.owner_tags_on(nil, :tags).collect { |t| t.name }.all? { |n| new_tags3.include?(n) }.should == true
      end
    end

    context "when tags are cleared" do
      before(:each) do
        stored_file.update_tags(new_tags.join(', '), :tags, user)
        stored_file.update_tags('', :tags, user2)
      end

      it "stored file should have no tags" do
        stored_file.owner_tags_on(nil, :tags).collect { |t| t.name }.should ==
          []
      end
    end
  end

  describe "#users_via_groups" do
    let(:stored_file) { Factory(:stored_file) }
    let(:user) { Factory(:user, :email => "test1@email.com") }
    let(:user2) { Factory(:user, :email => "test2@email.com") }
    let(:user3) { Factory(:user, :email => "test3@email.com") }
    let(:group) { Factory(:group) }

    context "when stored file has group and group has users" do
      before(:each) do
        stored_file.groups << group
        group.users = [user, user2, user3]
      end
      it "stored file users_via_groups should map to users" do
        stored_file.users_via_groups.should == [user, user2, user3]
      end
    end
  end
end
