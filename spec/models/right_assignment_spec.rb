require 'spec_helper'

describe RightAssignment do
  it { should belong_to(:right) }
  it { should belong_to(:subject, :polymorphic => true) }
  it { should allow_mass_assignment_of :right_id }

  describe "after create,destroy" do
    describe "destroy_preserved_flag_stored_files_cache" do
      before do
        @stored_file = FactoryGirl.create(:stored_file)
        @preserved_stored_file = FactoryGirl.create(:stored_file)
        flag = FactoryGirl.create(:flag, :name => "PRESERVED")
        FactoryGirl.create(:flagging, :stored_file => @preserved_stored_file, :flag => flag) 
        @user = FactoryGirl.create(:user)
      end
      
      context "when a user is assigned a right" do
        before do
          @cached_viewable_users_before_right_assignment = StoredFile.cached_viewable_users(@preserved_stored_file)
          @user.rights << FactoryGirl.create(:right, :action => "view_preserved_flag_content")
        end
        
        it "stored files with the preserved flag set should add the user to the viewable_users cache" do
          assert !@cached_viewable_users_before_right_assignment.include?(@user.id)
          assert StoredFile.cached_viewable_users(@preserved_stored_file.id).include?(@user.id)
        end

        it "should not affect stored files without the preserved flag" do
          assert !StoredFile.cached_viewable_users(@stored_file.id).include?(@user.id)
        end
  
        context "after destroying that right" do
          before do
            @user.rights.first.destroy
          end

          it "stored files with the preserved flag set should remove the user to the viewable_users cache" do
            assert !StoredFile.cached_viewable_users(@preserved_stored_file.id).include?(@user.id)
          end
          
          it "should not affect stored files without the preserved flag" do
            assert !StoredFile.cached_viewable_users(@stored_file.id).include?(@user.id)
          end
        end #context after destroying that right
      end #context when user assigns right directly

      context "when a group is assigned a right" do

        before do
          @cached_viewable_users_before_right_assignment = StoredFile.cached_viewable_users(@preserved_stored_file)
          @group = FactoryGirl.create(:group, :assignable_rights => true)
          Membership.add_users_to_groups([@user], [@group])
          @group.rights << FactoryGirl.create(:right, :action => "view_preserved_flag_content")
        end
        
        it "stored files with the preserved flag set should add the user to the viewable_users cache" do
          assert !@cached_viewable_users_before_right_assignment.include?(@user.id)
          assert StoredFile.cached_viewable_users(@preserved_stored_file.id).include?(@user.id)
        end

        it "should not affect stored files without the preserved flag" do
          assert !StoredFile.cached_viewable_users(@stored_file.id).include?(@user.id)
        end
  
        context "after destroying that right" do
          before do
            @group.rights.first.destroy
          end

          it "stored files with the preserved flag set should remove the user to the viewable_users cache" do
            assert !StoredFile.cached_viewable_users(@preserved_stored_file.id).include?(@user.id)
          end
          
          it "should not affect stored files without the preserved flag" do
            assert !StoredFile.cached_viewable_users(@stored_file.id).include?(@user.id)
          end
        end #context after destroying that right
      end #context group assignment

      context "when a role is assigned a right" do

        before do
          @cached_viewable_users_before_right_assignment = StoredFile.cached_viewable_users(@preserved_stored_file)
          @role = FactoryGirl.create(:role)
          @user.roles << @role
          @role.rights << FactoryGirl.create(:right, :action => "view_preserved_flag_content")
        end
        
        it "stored files with the preserved flag set should add the user to the viewable_users cache" do
          assert !@cached_viewable_users_before_right_assignment.include?(@user.id)
          assert StoredFile.cached_viewable_users(@preserved_stored_file.id).include?(@user.id)
        end

        it "should not affect stored files without the preserved flag" do
          assert !StoredFile.cached_viewable_users(@stored_file.id).include?(@user.id)
        end
  
        context "after destroying that right" do
          before do
            @role.rights.first.destroy
          end

          it "stored files with the preserved flag set should remove the user to the viewable_users cache" do
            assert !StoredFile.cached_viewable_users(@preserved_stored_file.id).include?(@user.id)
          end
          
          it "should not affect stored files without the preserved flag" do
            assert !StoredFile.cached_viewable_users(@stored_file.id).include?(@user.id)
          end
        end #context after destroying that right
      end #context role assignment

    end #describe destroy_preserved_flag
  end #describe after create,estroy
end #dewscribe Right Assignment
