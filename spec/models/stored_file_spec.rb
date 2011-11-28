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
  it { should have_many :groups }
  it { should have_one :disposition }

  it { should accept_nested_attributes_for :flaggings }
  it { should accept_nested_attributes_for :disposition }
  it { should accept_nested_attributes_for :comments }
  it { should accept_nested_attributes_for :groups_stored_files }

  # Examples of double / stub
  #stored_file = double("stored_file")
  #stored_file.stub(:flags).and_return([flag])
  #flag = Factory(:flag)
  #Flag.stub!(:preserved).and_return([flag])
  #FlagClass = doubleflag.stub(:name).and_return(Flag.PRESERVED_NAMES.first) # set name to PRESERVED

  describe "#display_name" do
    let(:stored_file) { Factory(:stored_file, :title => "Test Name") }
    let(:stored_file2) { Factory(:stored_file, :original_filename => "foobar") }

    context "when stored file has title" do
      it "should return title" do
        stored_file.display_name.should == stored_file.title
      end
    end

    context "when stored file has no title" do
      it "should return original_filename" do
        stored_file2.display_name.should == stored_file2.original_filename
      end
    end
  end

  describe "#license_name" do
    let(:license) { Factory(:license) }
    let(:stored_file) { Factory(:stored_file, :license_id => license.id) }
    let(:stored_file2) { Factory(:stored_file, :original_filename => "filename") }

    context "when stored file has license" do
      it "should return license name" do
        stored_file.license_name.should == license.name
      end
    end

    context "when stored file has no license" do
      it "should return original_filename" do
        stored_file2.license_name.should == "filename"
      end
    end
  end

  describe "#has_preserved_flag?" do
    let(:stored_file) { Factory(:stored_file) }

    context "when stored file has a preserved flag" do
      before(:each) do
        flag = Factory(:preserved_flag)
        flagging = Factory(:flagging, :flag_id => flag.id, :stored_file_id => stored_file.id)
      end
      it "should return true" do
        stored_file.has_preserved_flag?.should == true
      end
    end
    context "when stored file does not have a preserved flag" do
      before(:each) do
        flag = Factory(:flag)
        flagging = Factory(:flagging, :flag_id => flag.id, :stored_file_id => stored_file.id)
      end
      it "should return false" do
        stored_file.has_preserved_flag?.should == false
      end
    end
  end

  describe "#has_preserved_or_record_flag?" do
    let(:stored_file) { Factory(:stored_file) }

    context "when stored file has a selected flag" do
      before(:each) do
        flag = Factory(:selected_flag)
        flagging = Factory(:flagging, :flag_id => flag.id, :stored_file_id => stored_file.id)
      end
      it "should return true" do
        stored_file.has_preserved_or_record_flag?.should == true
      end
    end
    context "when stored file does not have a selected flag" do
      before(:each) do
        flag = Factory(:flag)
        flagging = Factory(:flagging, :flag_id => flag.id, :stored_file_id => stored_file.id)
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

  describe "#can_user_destroy?" do
    let(:user1) { Factory(:user, :email => "test1@email.com") }
    let(:stored_file1) { Factory(:stored_file, :user_id => user1.id) }
    let(:user2) { Factory(:user, :email => "test2@email.com") }
    let(:stored_file2) { Factory(:stored_file, :user_id => user2.id) }
    let(:stored_file3) { Factory(:stored_file, :user_id => user2.id) }
    let(:right) { Factory(:right, :action => "delete_items") }
    let(:user3) { Factory(:user, :email => "test3@email.com") }
    
    context "when user has global delete_right and does not own stored file" do
      before(:each) do
        user1.rights << right 
      end
      it "should allow delete on stored file" do
        stored_file1.can_user_destroy?(user1).should == true
      end 
    end 
    context "when user owns stored file and is contributor and stored file has preserved, record flag" do
      before(:each) do
        flag = Factory(:preserved_flag)
        Flagging.create(:flag_id => flag.id, :user_id => user2.id, :stored_file_id => stored_file2.id)
      end
      it "should allow delete on stored file" do
        stored_file2.can_user_destroy?(user2).should == true
      end 
    end 
    context "when user owns stored file and is contributor stored file does not have preserved, record flag" do
      it "should allow delete on stored file" do
        stored_file3.can_user_destroy?(user2).should == true 
      end 
    end
    context "when user doesn't own stored file" do
      it "should not allow delete on stored file" do
        stored_file3.can_user_destroy?(user3).should == false 
      end
    end 
  end

  #describe "#flag_map" do
  #end
end
