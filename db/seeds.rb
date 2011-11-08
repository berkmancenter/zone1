# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

AccessLevel.delete_all
Flag.delete_all
User.delete_all
Group.delete_all
StoredFile.delete_all
ContentType.delete_all
Role.delete_all
Right.delete_all
Disposition.delete_all
DispositionAction.delete_all

connection = ActiveRecord::Base.connection
connection.execute("DELETE FROM roles_users")

puts "Generating default preferences"
Preference.create([{:name => "Default User Upload Quota", :value => "10485760" }])

puts "Creating disposition actions"
DispositionAction.create([{ :action => "DELETE" },
                          { :action => "REVIEW" },
                          { :action => "TRANSFER" }])

puts "Generating access levels"
AccessLevel.create([{ :name => 'open', :label => 'Open' },
                    { :name => 'dark', :label => 'Dark' },
                    { :name => 'partially_open', :label => 'Partially Open' }])
(a1, a2, a3) = AccessLevel.all

puts "Generating flags"
Flag.create([{ :name => 'NOMINATED_FOR_PRESERVATION', :label => 'Nominated for Preservation' },
            { :name => 'SELECTED_FOR_PRESERVATION', :label => 'Selected for Preservation' },
            { :name => 'PRESERVED', :label => 'Preserved' },
            { :name => 'MAY_BE_UNIVERSITY_RECORD', :label => 'May be University Record' },
            { :name => 'UNIVERSITY_RECORD', :label => 'University Record' }])

puts "Generating content type"
ContentType.create([{ :name => "image" }, { :name => "doc" }])
(c1, c2) = ContentType.all

puts "Generating users"
User.create([{ :email => 'steph@endpoint.com', :password => 'berkman', :password_confirmation => 'berkman', :name => 'Steph' },
             {:email => 'bgadoury@endpoint.com', :password => 'berkman', :password_confirmation => 'berkman', :name => 'Phunk' },
             {:email => 'etann@endpoint.com', :password => 'berkman', :password_confirmation => 'berkman', :name => 'Evan' },
             {:email => 'admin@endpoint.com', :password => 'berkman', :password_confirmation => 'berkman', :name => 'Admin' },
             {:email => 'brianb@endpoint.com', :password => 'berkman', :password_confirmation => 'berkman', :name => 'Brian' }])
(u1, u2, u3, u4, u5) = User.all

puts "Generating groups"
Group.create([{ :name => "End Point" },
              { :name => "Test 1" },
              { :name => "Test 2" },
              { :name => "Test 3" }])
(g1, g2, g3, g4) = Group.all

g1.users << User.all
g1.owners << u1
g2.users = [u1, u2]
g2.owners << u1
g3.users = [u1, u2]
g3.owners << u1
g4.users = [u1, u2]
g4.owners << u1

puts "Generating rights"
Right.create([{ :action => "toggle_preserved", :description => "Ability to toggle PRESERVED flag." },
  { :action => "toggle_nominated_for_preservation", :description => "Ability to toggle NOMINATED_FOR_PRESERVATION flag." },
  { :action => "toggle_selected_for_preservation", :description => "Ability to toggle SELECTED_FOR_PRESERVATION flag." },
  { :action => "toggle_university_record", :description => "Ability to toggle UNIVERSITY_RECORD flag." },
  { :action => "toggle_may_be_university_record", :description => "Ability to toggle MAY_BE_UNIVERSITY_RECORD flag." },
  { :action => "toggle_open", :description => "Ability to set access level to open on any content." },
  { :action => "toggle_open_on_owned", :description => "Ability to set access level to open on content owned by you." },
  { :action => "toggle_partially_open", :description => "Ability to set access level to partially open on any content." },
  { :action => "toggle_partially_open_on_owned", :description => "Ability to set access level to partially open on content owned by you." },
  { :action => "toggle_dark", :description => "Ability to set access level to dark on any content." },
  { :action => "toggle_dark_on_owned", :description => "Ability to set access level to dark on content owned by you." },
  { :action => "manage_disposition", :description => "Ability to update disposition on any content." },
  { :action => "delete_items", :description => "Ability to delete any content." },
  { :action => "delete_items_on_owned", :description => "Ability to delete content owned by you." },
  { :action => "view_items", :description => "Ability to view any content." }, 
  { :action => "view_items_on_owned", :description => "Ability to view content owned by you." },
  { :action => "view_preserved_flag_content", :description => "Ability to view any content with preservation flag." },
  { :action => "delete_comments", :description => "Ability to manage comments on any content." },
  { :action => "delete_comments_on_owned", :description => "Ability to manage comments on content owned by you." },
  { :action => "edit_items", :description => "Ability to edit metadata of any content." },
  { :action => "edit_items_on_owned", :description => "Ability to edit metadata on content owned by you." },
  { :action => "edit_groups", :description => "Ability to edit metadata and members of any group." },
  { :action => "edit_groups_on_owned", :description => "Ability to edit metadata and members on groups owned by you." },
  { :action => "view_reports", :description => "Ability to view any reports."},
  { :action => "view_reports_on_owned", :description => "Ability to view reports on content owned by you."},
  { :action => "view_admin", :description => "Ability to view admin interface."}])
(ri1, ri2, ri3, ri4, ri5, ri6, ri7, ri8, ri9, ri10,
 ri11, ri12, ri13, ri14, ri15, ri16, ri17, ri18, ri19, ri20,
 ri21, ri22, ri23, ri24, ri25) = Right.all

puts "Generating roles"
Role.create([{ :name => "admin" },
  { :name => "steward" },
  { :name => "records_manager" },
  { :name => "user" }])
(r1, r2, r3, r4) = Role.all

r1.rights = Right.all
r1.save
r2.rights = [ri1, ri2, ri3, ri17] # preservation flags, view preserved flag content
r2.save
r3.rights = [ri4, ri5, ri6, ri8, ri10, ri12, ri15] #university flags, accessibility, view any content, manage_dispositions
r3.save
r4.rights = [ri2, ri5, ri9, ri11, ri14, ri16, ri19, ri21, ri23, ri25] #nominate preservation flag, partially open and dark settings, view own content, manage own comments 
r4.save

# Assign user role to all users
u1.roles << [r1, r4]
u2.roles << r4
u3.roles << r4
u4.roles << [r1, r4]
u5.roles << [r1, r4]

puts "Generating licenses"
License.create([{ :name => 'CC BY' },
        { :name => 'CC BY-SA' },
        { :name => 'CC BY-ND' },
        { :name => 'CC BY-NC' },
        { :name => 'CC BY-NC-SA' },
        { :name => 'CC BY-NC-ND' }])

