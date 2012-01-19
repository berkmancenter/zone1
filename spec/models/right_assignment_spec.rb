require 'spec_helper'

describe RightAssignment do
  it { should belong_to(:right) }
  it { should belong_to(:subject) }
  it { should allow_mass_assignment_of :right_id }

  describe "after create,destroy" do
    describe "destroy_perserved_flag_stored_files_cache" do
      before do
        @stored_file = Factory(:stored_file)
        @perserved_stored_file = Factory(:stored_file)
        flag = Factory(:flag, :name => "PRESERVED")
        Factory(:flagging, :stored_file => @perserved_stored_file, :flag => flag) 
        @user = Factory(:user)
      end
      
      context "when a user is assigned a right" do
        before do
          @cached_viewable_users_before_right_assignment = StoredFile.cached_viewable_users(@perserved_stored_file)
          @user.rights << Factory(:right, :action => "view_preserved_flag_content")
        end
        
        it "stored files with the perserved flag set should add the user to the viewable_users cache" do
          assert !@cached_viewable_users_before_right_assignment.include?(@user.id)
          assert StoredFile.cached_viewable_users(@perserved_stored_file.id).include?(@user.id)
        end

        it "should not affect stored files without the perserved flag" do
          assert !StoredFile.cached_viewable_users(@stored_file.id).include?(@user.id)
        end
  
        context "after destroying that right" do
          before do
            @user.rights.first.destroy
          end

          it "stored files with the perserved flag set should add the user to the viewable_users cache" do
            assert !StoredFile.cached_viewable_users(@perserved_stored_file.id).include?(@user.id)
          end
          
          it "should not affect stored files without the perserved flag" do
            assert !StoredFile.cached_viewable_users(@stored_file.id).include?(@user.id)
          end
        end #context after destroying that right
      end #context when user assigns right directly

      context "when a group is assigned a right" do

        before do
          @cached_viewable_users_before_right_assignment = StoredFile.cached_viewable_users(@perserved_stored_file)
          @group = Factory(:group, :assignable_rights => true)
          Membership.add_users_to_groups([@user], [@group])
          @group.rights << Factory(:right, :action => "view_preserved_flag_content")
        end
        
        it "stored files with the perserved flag set should add the user to the viewable_users cache" do
          assert !@cached_viewable_users_before_right_assignment.include?(@user.id)
          assert StoredFile.cached_viewable_users(@perserved_stored_file.id).include?(@user.id)
        end

        it "should not affect stored files without the perserved flag" do
          assert !StoredFile.cached_viewable_users(@stored_file.id).include?(@user.id)
        end
  
        context "after destroying that right" do
          before do
            @group.rights.first.destroy
          end

          it "stored files with the perserved flag set should add the user to the viewable_users cache" do
            assert !StoredFile.cached_viewable_users(@perserved_stored_file.id).include?(@user.id)
          end
          
          it "should not affect stored files without the perserved flag" do
            assert !StoredFile.cached_viewable_users(@stored_file.id).include?(@user.id)
          end
        end #context after destroying that right
      end #context group assignment

      context "when a role is assigned a right" do

        before do
          @cached_viewable_users_before_right_assignment = StoredFile.cached_viewable_users(@perserved_stored_file)
          @role = Factory(:role)
          @user.roles << @role
          @role.rights << Factory(:right, :action => "view_preserved_flag_content")
        end
        
        it "stored files with the perserved flag set should add the user to the viewable_users cache" do
          assert !@cached_viewable_users_before_right_assignment.include?(@user.id)
          assert StoredFile.cached_viewable_users(@perserved_stored_file.id).include?(@user.id)
        end

        it "should not affect stored files without the perserved flag" do
          assert !StoredFile.cached_viewable_users(@stored_file.id).include?(@user.id)
        end
  
        context "after destroying that right" do
          before do
            @role.rights.first.destroy
          end

          it "stored files with the perserved flag set should add the user to the viewable_users cache" do
            assert !StoredFile.cached_viewable_users(@perserved_stored_file.id).include?(@user.id)
          end
          
          it "should not affect stored files without the perserved flag" do
            assert !StoredFile.cached_viewable_users(@stored_file.id).include?(@user.id)
          end
        end #context after destroying that right
      end #context role assignment

    end #describe destroy_perserved_flag
  end #describe after create,estroy
end #dewscribe Right Assignment
