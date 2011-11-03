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
g = Group.new(:name => 'End Point')
g.users << User.all
g.owners << u1
g.save

puts "Generating rights"
Right.create([{ :method => "toggle_preserved", :description => "Ability to toggle PRESERVED flag." },
  { :method => "toggle_nominated_for_preservation", :description => "Ability to toggle NOMINATED_FOR_PRESERVATION flag." },
  { :method => "toggle_selected_for_preservation", :description => "Ability to toggle SELECTED_FOR_PRESERVATION flag." },
  { :method => "toggle_university_record", :description => "Ability to toggle UNIVERSITY_RECORD flag." },
  { :method => "toggle_may_be_university_record", :description => "Ability to toggle MAY_BE_UNIVERSITY_RECORD flag." },
  { :method => "toggle_open", :description => "Ability to set access level to open on any content." },
  { :method => "toggle_open_to_own_content", :description => "Ability to set access level to open on content owned by you." },
  { :method => "toggle_partially_open", :description => "Ability to set access level to partially open on any content." },
  { :method => "toggle_partially_open_to_own_content", :description => "Ability to set access level to partially open on content owned by you." },
  { :method => "toggle_dark", :description => "Ability to set access level to dark on any content." },
  { :method => "toggle_dark_to_own_content", :description => "Ability to set access level to dark on content owned by you." },
  { :method => "manage_disposition", :description => "Ability to update disposition on any content." },
  { :method => "delete_items", :description => "Ability to delete any content." },
  { :method => "delete_items_to_own_content", :description => "Ability to delete content owned by you." },
  { :method => "view_items", :description => "Ability to view any content." }, 
  { :method => "view_items_to_own_content", :description => "Ability to view content owned by you." },
  { :method => "view_preserved_flag_content", :description => "Ability to view any content with preservation flag." },
  { :method => "delete_comments", :description => "Ability to manage comments on any content." },
  { :method => "delete_comments_to_own_content", :description => "Ability to manage comments on content owned by you." },
  { :method => "edit_items", :description => "Ability to edit metadata of any content." },
  { :method => "edit_items_to_own_content", :description => "Ability to edit metadata on content owned by you." }])
(ri1, ri2, ri3, ri4, ri5, ri6, ri7, ri8, ri9, ri10,
 ri11, ri12, ri13, ri14, ri15, ri16, ri17, ri18, ri19, ri20,
 ri21) = Right.all

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
r4.rights = [ri2, ri5, ri9, ri11, ri14, ri16, ri19, ri21] #nominate preservation flag, partially open and dark settings, view own content, manage own comments 
r4.save

# Assign user role to all users
u1.roles << r4
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

=begin
puts "Generating stored files"
40.times do
  StoredFile.create([{:original_filename => "file_#{rand(36**8).to_s(36)}", :user_id => u1.id, :access_level_id => a1.id, :content_type_id => c1.id},
             {:original_filename => "file_#{rand(36**8).to_s(36)}", :user_id => u1.id, :access_level_id => a2.id, :content_type_id => c1.id},
             {:original_filename => "file_#{rand(36**8).to_s(36)}", :user_id => u2.id, :access_level_id => a1.id, :content_type_id => c1.id},
             {:original_filename => "file_#{rand(36**8).to_s(36)}", :user_id => u3.id, :access_level_id => a1.id, :content_type_id => c2.id}]) 
end


puts "Adding tags"
StoredFile.all.each do |a|
  a.tag_list = "paper"
  a.license = License.find(1)
  a.save
  a.flags << Flag.first
end

sf = StoredFile.first
sf.tag_list = "dissertation"
sf.flags << Flag.last
sf.license = License.find(2)
sf.save

sf = StoredFile.last
sf.tag_list = "thesis"
sf.license = License.find(3)
sf.save
=end
