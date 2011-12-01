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
    let(:stored_file2) { Factory(:stored_file) }

    context "when stored file has license" do
      it "should return license name" do
        stored_file.license_name.should == license.name
      end
    end

    context "when stored file has no license" do
      it "should return nil" do
        stored_file2.license_name.should == nil
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
    let(:user) { Factory(:user) }
    let(:user2) { Factory(:user) }

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
    let(:user) { Factory(:user) }
    let(:user2) { Factory(:user) }
    let(:user3) { Factory(:user) }
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
    let(:user1) { Factory(:user) }
    let(:stored_file1) { Factory(:stored_file, :user_id => user1.id) }
    let(:user2) { Factory(:user) }
    let(:stored_file2) { Factory(:stored_file, :user_id => user2.id) }
    let(:stored_file3) { Factory(:stored_file, :user_id => user2.id) }
    let(:right) { Factory(:right, :action => "delete_items") }
    let(:user3) { Factory(:user) }
    
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

  describe "#custom_save" do
   
    before :all do
     @user = Factory(:user)  #only initialize the user once, instead of each time
    end

    let(:stored_file) do
      sf=StoredFile.new
      sf.user = @user
      sf.access_level = Factory(:access_level)
      sf
    end

    let(:params) { {} }

    context "when the uploaded file's extension is blacklisted and this is a new record" do
      it "should raise an error" do
        Factory(:mime_type, :blacklist => true, :extension => ".exe")
        assert_raise Exception do
          stored_file.custom_save({"original_filename" => "virus.exe"}, @user)
        end
      end
    end

    it "set's accessible using attr_accessible_for" do
      stored_file.should_receive(:attr_accessible_for).with(params, @user).and_return([:test_list])
      stored_file.should_receive("accessible=").with([:test_list])
      stored_file.custom_save(params, @user)
    end

    it "should call flaggings_server_side_validation" do
      stored_file.should_receive(:flaggings_server_side_validation).with(params, @user)
      stored_file.custom_save(params, @user)
    end

    it "should call prepare_comment_params" do
      stored_file.should_receive(:prepare_comment_params).with(params, @user)
      stored_file.custom_save(params, @user)
    end


    context "when update_attributes returns true" do

      before :each do
        stored_file.should_receive(:update_attributes).with(params).and_return(true)
      end

      after :each do
        stored_file.custom_save(params, @user)
      end

      context "when tag_list is present in params" do

        before :all do
          @tag_list = "tag1,tag2,tag3"
          params.merge!({:tag_list => @tag_list})
        end

        it "should update tags" do
          stored_file.should_receive(:update_tags).with(@tag_list, :tags, @user)
        end 

        it "should remove tag_list from params" do
          params.has_key?(:tag_list).should_not == true
        end
      end

      context "when collection_list is present in params" do
        before :all do
          @collection_list = "collection1,collection2"
          params.merge! :collection_list => @collection_list
        end
        it "should update tags" do
          stored_file.should_receive(:update_tags).with(@collection_list, :collections, @user)
        end
        it "should remove collection_list from params" do
          params.has_key?(:collection_list).should_not == true
        end
      end 
    end



    context "when update_attributes returns false" do
      it "should raise an exception" do
        stored_file.should_receive(:update_attributes).with(params).and_return(false)
        assert_raise Exception do
          stored_file.custom_save(params, @user)
        end
      end
    end

  end

  describe ".cached_viewable_users" do
    let(:user1) { Factory(:user) }
    let(:user2) { Factory(:user) }
    let(:user3) { Factory(:user) }
    let(:group) { Factory(:group) }
    let(:role) { Factory(:role) }
    let(:stored_file) { Factory(:stored_file, :user_id => user2.id) }
    let(:flag) { Factory(:preserved_flag) }

    context "stored file that is open" do
      before :each do
        stored_file.access_level.update_attribute(:name, "open")
        user1.inspect
      end
      it "should be accessible to non-owner" do
        StoredFile.cached_viewable_users(stored_file.id).include?(user1.id).should == true    
      end
    end

    context "stored file that is partially open" do
      before :each do
        stored_file.access_level.update_attribute(:name, "partially_open")
        user1.inspect
      end
      it "should be accessible to owner" do
        StoredFile.cached_viewable_users(stored_file.id).include?(user1.id).should == false
      end
      it "should not be accessible to non-owner" do
        StoredFile.cached_viewable_users(stored_file.id).include?(user2.id).should == true    
      end
    end

    context "stored file that is partially open" do
      before :each do
        stored_file.access_level.update_attribute(:name, "partially_open")
        group.users << user3
        stored_file.groups << group
        user1.inspect
      end
      it "should be accessible to member of group assigned to stored file" do
        StoredFile.cached_viewable_users(stored_file.id).include?(user3.id).should == true
      end
    end

    context "stored file that is dark with preserved flag" do
      before :each do
        stored_file.access_level.update_attribute(:name, "dark")
        role.users << user3
        role.rights << Factory(:right, :action => "view_preserved_flag_content")
        Flagging.create(:flag_id => flag.id, :user_id => user2.id, :stored_file_id => stored_file.id)
      end
      it "should be accessible to user with view_preserved_flag_content right" do
        StoredFile.cached_viewable_users(stored_file.id).include?(user3.id).should == true
      end
      it "should not be accessible to non-member of group assigned to stored file" do
        StoredFile.cached_viewable_users(stored_file.id).include?(user1.id).should == false
      end
    end

    context "cache on this method" do
      it "should exist after called" do
        result = StoredFile.cached_viewable_users(stored_file.id).include?(user1.id)
        Rails.cache.exist?("stored-file-#{stored_file.id}-viewable-users").should == true
      end
      it "should expire after stored file is updated" do
        result = StoredFile.cached_viewable_users(stored_file.id).include?(user1.id)
        stored_file.update_attribute(:original_filename, "original.txt")
        Rails.cache.exist?("stored-file-#{stored_file.id}-viewable-users").should == false
      end
      it "should expire after stored file is destroyed" do
        result = StoredFile.cached_viewable_users(stored_file.id).include?(user1.id)
        stored_file.destroy
        Rails.cache.exist?("stored-file-#{stored_file.id}-viewable-users").should == false
      end
    end
  end
  
  describe "#attr_accessible_for(params,user)" do
   
    before :each do
      @stored_file = Factory(:stored_file)
      @params = {}
      @user = Factory(:user)
    end
   
    it "should include ALWAYS_ACCESSIBLE_ATTRIBUTES" do
      (@stored_file.attr_accessible_for(@params, @user) & StoredFile::ALWAYS_ACCESSIBLE_ATTRIBUTES).should == StoredFile::ALWAYS_ACCESSIBLE_ATTRIBUTES
    end
    
    context "when a new record" do
      it "should include CREATE_ATTRIBUTES" do
        @stored_file = StoredFile.new
        (@stored_file.attr_accessible_for(@params, @user) & StoredFile::CREATE_ATTRIBUTES).should == StoredFile::CREATE_ATTRIBUTES
      end
    end


    context "when an existing record" do
      it "should NOT include CREATE_ATTRIBUTES" do
        (@stored_file.attr_accessible_for(@params, @user) & StoredFile::CREATE_ATTRIBUTES).should == []
      end
    
    
      context "user can do method 'edit_items'" do
        it "should include ALLOW_MANAGE_ATTRIBUTES" do
          @user.should_receive("can_do_method?").with(@stored_file, "edit_items").and_return(true)
          (@stored_file.attr_accessible_for(@params, @user) & StoredFile::ALLOW_MANAGE_ATTRIBUTES).should == StoredFile::ALLOW_MANAGE_ATTRIBUTES
        end
      end


      context "user can not do method 'edit_items'" do
        it "should NOT include aLLOW_MANAGE_ATTRIBUTES" do
          @user.should_receive("can_do_method?").with(@stored_file, "edit_items").and_return(false)
          (@stored_file.attr_accessible_for(@params, @user) & StoredFile::ALLOW_MANAGE_ATTRIBUTES).should == []
        end
      end

      context "when new access_level_id is set" do
        before :each do
          @access_level = Factory(:access_level)
          @params = {:access_level_id => @access_level.id }
        end
        
        context "when user cannot set the access_level" do
          it "should include access_level_id in the attribute list" do
            @user.should_receive("can_set_access_level?").with(@stored_file, @access_level).and_return(false)
            @stored_file.attr_accessible_for(@params, @user).include?(:access_level_id).should == false
          end
        end 
        
        context "when user can set the access_level" do
          it "should include access_level_id in the attribute list" do
            @user.should_receive("can_set_access_level?").with(@stored_file, @access_level).and_return(true)
            @stored_file.attr_accessible_for(@params, @user).include?(:access_level_id).should == true
          end
        end 
      end

      context "when access_level_id is same as what's already defined" do
        it "should not set the access level again" do
          @stored_file.access_level = @access_level
          @stored_file.attr_accessible_for(@params, @user).include?(:access_level_id).should == false
        end
      end

      context "when allow_tags=true" do
        before :each do
          @stored_file.should_receive(:allow_tags).and_return(true)
        end
        it "should include :tag_list in attribute list" do
          assert @stored_file.attr_accessible_for(@params, @user).include?(:tag_list)
        end
      end

      context "when allow_tags=false" do
        before :each do
          @stored_file.should_receive(:allow_tags).and_return(false)
        end
        it "should not include :tag_list in attribute list" do
          assert !@stored_file.attr_accessible_for(@params, @user).include?(:tag_list)
        end
      end
    end
  end

  describe "#mime_type_category_id" do
    context "when a mime type is present and a mime type category is present" do
      before do
        @mime_type_category = Factory(:mime_type_category)
        @mime_type = Factory(:mime_type, :mime_type_category => @mime_type_category)
        @stored_file = Factory(:stored_file, :mime_type => @mime_type)
      end
      it "should return the mime type category id" do
        @stored_file.mime_type_category_id.should == @mime_type_category.id
      end
    end

    context "when no mime type is assigned" do
      before do
        @stored_file = Factory(:stored_file)
        @stored_file.mime_type = nil
      end
      it "should return nil" do
        assert_nil @stored_file.mime_type_category_id
      end
    end

    context "when a mime type is present without a mime type category" do
      before do
        @mime_type = Factory(:mime_type)
        @mime_type.mime_type_category = nil
        @stored_file = Factory(:stored_file, :mime_type => @mime_type)
      end
      it "should return nil" do
        assert_nil @stored_file.mime_type_category_id
      end
    end    
  end

  #describe "#flag_map" do
  #end
end
