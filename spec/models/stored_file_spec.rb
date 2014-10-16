require 'spec_helper'

describe StoredFile do
  it { should belong_to :license }
  it { should belong_to :user }
  it { should belong_to :access_level }
  it { should belong_to :batch }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:flaggings).dependent(:destroy) }
  it { should have_many :flags }
  it { should have_many(:groups_stored_files).dependent(:destroy) }
  it { should have_many :groups }
  it { should have_one(:disposition).dependent(:destroy) }
  it { should have_one(:mime_type_category).through(:mime_type) }
  it { should belong_to :mime_type }

  it { should accept_nested_attributes_for :flaggings }
  it { should accept_nested_attributes_for :disposition }
  it { should accept_nested_attributes_for :comments }
  it { should accept_nested_attributes_for :groups_stored_files }

  # Examples of double / stub
  #stored_file = double("stored_file")
  #stored_file.stub(:flags).and_return([flag])
  #flag = FactoryGirl.create(:flag)
  #flag.stub!(:preserved).and_return([flag])
  #FlagClass = doubleflag.stub(:name).and_return(Flag.PRESERVED_NAMES.first) # set name to PRESERVED

  describe "#license_name" do
    let(:license) { FactoryGirl.create(:license, :name => "to_ill") }
    let(:stored_file) { FactoryGirl.create(:stored_file, :license_id => license.id) }

    it "should delegate to license.name" do
      stored_file.license_name.should == "to_ill"
    end
  end

  describe "#has_preserved_flag?" do
    let(:stored_file) { FactoryGirl.create(:stored_file) }

    context "when stored file has a preserved flag" do
      before(:each) do
        flag = FactoryGirl.create(:preserved_flag)
        flagging = FactoryGirl.create(:flagging, :flag_id => flag.id, :stored_file_id => stored_file.id)
      end
      it "should return true" do
        stored_file.has_preserved_flag?.should == true
      end
    end
    context "when stored file does not have a preserved flag" do
      before(:each) do
        flag = FactoryGirl.create(:flag)
        flagging = FactoryGirl.create(:flagging, :flag_id => flag.id, :stored_file_id => stored_file.id)
      end
      it "should return false" do
        stored_file.has_preserved_flag?.should == false
      end
    end
  end

  describe "#has_preserved_or_record_flag?" do
    let(:stored_file) { FactoryGirl.create(:stored_file) }

    context "when stored file has a selected flag" do
      before(:each) do
        flag = FactoryGirl.create(:selected_flag)
        flagging = FactoryGirl.create(:flagging, :flag_id => flag.id, :stored_file_id => stored_file.id)
      end
      it "should return true" do
        stored_file.has_preserved_or_record_flag?.should == true
      end
    end
    context "when stored file does not have a selected flag" do
      before(:each) do
        flag = FactoryGirl.create(:flag)
        flagging = FactoryGirl.create(:flagging, :flag_id => flag.id, :stored_file_id => stored_file.id)
      end
      it "should return false" do
        stored_file.has_preserved_or_record_flag?.should == false
      end
    end
  end

  describe "#update_tags" do
    let(:stored_file) { FactoryGirl.create(:stored_file) }
    let(:new_tags) { ["test1", "test2"] }
    let(:new_tags2) { ["test3", "test4"] }
    let(:new_tags3) { ["test2", "test3"] }
    let(:user) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }

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
        stored_file.owner_tags_on(nil, :tags).collect { |t| t.name }.should == []
      end
    end
  end

  describe "#users_via_groups" do
    let(:stored_file) { FactoryGirl.create(:stored_file) }
    let(:user) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }
    let(:user3) { FactoryGirl.create(:user) }
    let(:group) { FactoryGirl.create(:group) }

    context "when stored file has group and group has users" do
      before(:each) do
        stored_file.groups << group
        Membership.add_users_to_groups([user, user2, user3], [group])
      end
      it "stored file users_via_groups should map to users" do
        Set.new(stored_file.users_via_groups).should == Set.new([user.id, user2.id, user3.id])
      end
    end
  end

  describe "#can_user_destroy?" do
    let(:user1) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }
    let(:user3) { FactoryGirl.create(:user) }
    let(:stored_file1) { FactoryGirl.create(:stored_file, :user_id => user1.id) }
    let(:stored_file2) { FactoryGirl.create(:stored_file, :user_id => user2.id) }
    let(:stored_file3) { FactoryGirl.create(:stored_file, :user_id => user2.id) }
    let(:right) { FactoryGirl.create(:right, :action => "delete_items") }
    
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
        flag = FactoryGirl.create(:preserved_flag)
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
     @user = FactoryGirl.create(:user)  #only initialize the user once, instead of each time
    end

    
    let(:stored_file) do
      sf=StoredFile.new
      sf.user = @user
      sf.access_level = FactoryGirl.create(:access_level)
      sf.license = FactoryGirl.create(:license)
      sf
    end

    let(:params) { {} }

    context "when the uploaded file's extension is blacklisted and this is a new record" do
      it "should raise an error" do
        FactoryGirl.create(:mime_type, :blacklist => true, :extension => ".exe")
        assert_raise Exception do
          stored_file.custom_save({:original_filename => "virus.exe"}, @user)
        end
      end
    end

    it "set's accessible using attr_accessible_for" do
      stored_file.should_receive(:attr_accessible_for).with(params, @user).and_return([:test_list])
      stored_file.should_receive("accessible=").with([:test_list])
      stored_file.custom_save(params, @user)
    end

    it "should call prepare_flagging_params" do
      stored_file.should_receive(:prepare_flagging_params).with(params, @user)
      stored_file.custom_save(params, @user)
    end

    it "should call prepare_comment_params" do
      stored_file.should_receive(:prepare_comment_params).with(params, @user)
      stored_file.custom_save(params, @user)
    end


    context "when update_attributes returns true" do

      before :each do
        stored_file.should_receive(:update_attributes).and_return(true)
      end

      after :each do
        stored_file.custom_save(params, @user)
      end

      context "when tag_list is present in params" do
        before :all do
          @tag_list = "tag1,tag2,tag3"
          params.merge!({"tag_list" => @tag_list})
        end

        it "should update tags" do
          stored_file.should_receive(:update_tags).with(@tag_list, :tags, @user)
        end 

        it "should not modify params by removing tag_list" do
          params.has_key?("tag_list").should == true
        end
      end

      context "when collection_list is present in params" do
        before :all do
          @collection_list = "collection1,collection2"
          params.merge!({"collection_list" => @collection_list})
        end
        it "should update tags" do
          stored_file.should_receive(:update_tags).with(@collection_list, :collections, @user)
        end
        it "should not modify params by removing collection_list" do
          params.has_key?("collection_list").should == true
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
    let(:user1) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }
    let(:user3) { FactoryGirl.create(:user) }
    let(:group) { FactoryGirl.create(:group) }
    let(:role) { FactoryGirl.create(:role) }
    let(:stored_file) { FactoryGirl.create(:stored_file, :user_id => user2.id) }
    let(:flag) { FactoryGirl.create(:preserved_flag) }

    context "stored file that is open" do
      before :each do
        stored_file.access_level.update_column(:name, "open")
      end
    end

    context "stored file that is partially open to only its owner" do
      before :each do
        stored_file.access_level.update_column(:name, "partially_open")
      end
      it "should be accessible only to owner" do
        StoredFile.cached_viewable_users(stored_file.id).should == [user2.id]
      end
    end

    context "stored file that is partially open to a group" do
      before :each do
        stored_file.access_level.update_column(:name, "partially_open")
        Membership.add_users_to_groups([user3], [group])
        stored_file.groups << group
      end
      it "should be accessible to member of group assigned to stored file" do
        StoredFile.cached_viewable_users(stored_file.id).should include(user3.id)
      end
    end

    context "stored file that is dark with preserved flag" do
      before :each do
        stored_file.access_level.update_column(:name, "dark")
        role.users << user3
        role.rights << FactoryGirl.create(:right, :action => "view_preserved_flag_content")
        Flagging.create(:flag_id => flag.id, :user_id => user2.id, :stored_file_id => stored_file.id)
      end
      it "should be accessible to user with view_preserved_flag_content right" do
        StoredFile.cached_viewable_users(stored_file.id).should include(user3.id)
      end
      it "should not be accessible to non-member of group assigned to stored file" do
        StoredFile.cached_viewable_users(stored_file.id).should_not include(user1.id)
      end
    end

    context "cache on this method" do
      it "should exist after called" do
        Rails.cache.clear
        StoredFile.cached_viewable_users(stored_file.id)
        Rails.cache.exist?("stored-file-#{stored_file.id}-viewable-users").should == true
      end
      it "should expire after stored file is updated" do
        StoredFile.cached_viewable_users(stored_file.id)
        stored_file.accessible = [:original_filename]
        stored_file.update_attributes(:original_filename => "original.txt")
        Rails.cache.exist?("stored-file-#{stored_file.id}-viewable-users").should == false
      end
      it "should expire after stored file is destroyed" do
        StoredFile.cached_viewable_users(stored_file.id)
        stored_file.destroy
        Rails.cache.exist?("stored-file-#{stored_file.id}-viewable-users").should == false
      end
    end
  end
  
  describe "#attr_accessible_for(params,user)" do
   
    before :each do
      @stored_file = FactoryGirl.create(:stored_file)
      @params = {}
      @user = FactoryGirl.create(:user)
    end
   
    it "should include ALWAYS_ACCESSIBLE_ATTRIBUTES" do
      (@stored_file.attr_accessible_for(@params, @user) & StoredFile::ALWAYS_ACCESSIBLE_ATTRIBUTES).sort.should == StoredFile::ALWAYS_ACCESSIBLE_ATTRIBUTES.sort
    end
    
    context "when a new record" do
      it "should include CREATE_ATTRIBUTES" do
        @stored_file = StoredFile.new
        (@stored_file.attr_accessible_for(@params, @user) & StoredFile::CREATE_ATTRIBUTES).sort.should == StoredFile::CREATE_ATTRIBUTES.sort
      end
    end

    context "when an existing record" do
      it "should NOT include CREATE_ATTRIBUTES" do
        (@stored_file.attr_accessible_for(@params, @user) & StoredFile::CREATE_ATTRIBUTES).should == []
      end
    
    
      context "user can do method 'edit_items'" do
        it "should include ALLOW_MANAGE_ATTRIBUTES" do
          @user.should_receive("can_do_method?").with(@stored_file, "edit_items").and_return(true)
          (@stored_file.attr_accessible_for(@params, @user) & StoredFile::ALLOW_MANAGE_ATTRIBUTES).sort.should == StoredFile::ALLOW_MANAGE_ATTRIBUTES.sort
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
          @access_level = FactoryGirl.create(:access_level)
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
        @mime_type_category = FactoryGirl.create(:mime_type_category)
        @mime_type = FactoryGirl.create(:mime_type, :mime_type_category => @mime_type_category)
        @stored_file = FactoryGirl.create(:stored_file, :mime_type => @mime_type)
      end
      it "should return the mime type category id" do
        @stored_file.mime_type_category_id.should == @mime_type_category.id
      end
    end

    context "when no mime type is assigned" do
      before do
        @stored_file = FactoryGirl.create(:stored_file)
        @stored_file.mime_type = nil
      end
      it "should return nil" do
        assert_nil @stored_file.mime_type_category_id
      end
    end

    context "when a mime type is present without a mime type category" do
      before do
        @mime_type = FactoryGirl.create(:mime_type)
        @mime_type.mime_type_category = nil
        @stored_file = FactoryGirl.create(:stored_file, :mime_type => @mime_type)
      end
      it "should return nil" do
        assert_nil @stored_file.mime_type_category_id
      end
    end    
  end

  describe "post_process" do
    before :each do
      @stored_file = FactoryGirl.create(:stored_file)
    end

    after :each do
      @stored_file.post_process
    end
    
    it "should call set_fits_attributes and generate_thumbnail" do
      @stored_file.should_receive :set_fits_attributes
      @stored_file.should_receive :generate_thumbnail
      @stored_file.should_not_receive :save!
    end

    it "should call save!, StoredFile.cached_thumbnail_path(id) and index! if set_fits_attributes returns true" do
      @stored_file.stub(:set_fits_attributes).and_return(true)
      @stored_file.stub(:generate_thumbnail)
      @stored_file.should_receive(:save!)
      Rails.cache.should_receive(:delete).with("thumbnail-url-#{@stored_file.id}")
      StoredFile.should_receive(:cached_thumbnail_path).with(@stored_file.id)
      @stored_file.should_receive(:index!)
    end
    
    it "should call save!, StoredFile.cached_thumbnail_path(id) and index! if generate_thumbnail returns true" do
      @stored_file.stub(:set_fits_attributes)
      @stored_file.stub(:generate_thumbnail).and_return(true)
      @stored_file.should_receive(:save!)
      Rails.cache.should_receive(:delete).with("thumbnail-url-#{@stored_file.id}")
      StoredFile.should_receive(:cached_thumbnail_path).with(@stored_file.id)
      @stored_file.should_receive(:index!)
    end

  end
  
  describe "destroy_cache" do
    before :each do
      Tag.all
      @stored_file = FactoryGirl.create(:stored_file)
    end

    it "should destroy tag list caches when a file is created" do
      Rails.cache.exist?("tag-list").should == false
      Rails.cache.exist?("tag-list-all").should == false
    end
  end

end
