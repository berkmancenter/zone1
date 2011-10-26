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

connection = ActiveRecord::Base.connection
connection.execute("DELETE FROM roles_users")

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
             {:email => 'etann@endpoint.com', :password => 'berkman', :password_confirmation => 'berkman', :name => 'Evan' }])
(u1, u2, u3) = User.all

puts "Generating groups"
g = Group.new(:name => 'End Point', :user_id => u3.id)
g.users << User.all
g.save

Role.create([{ :name => "admin" },
  { :name => "steward" },
  { :name => "records_manager" },
  { :name => "user" }])
(r1, r2, r3, r4) = Role.all

Right.create([{ :method => "toggle_preserved" },
  { :method => "toggle_nominated" },
  { :method => "toggle_selected_for_preservation" },
  { :method => "toggle_univ_record" },
  { :method => "toggle_possible_univ_record" },
  { :method => "toggle_preserved_to_own_content" },
  { :method => "toggle_nominated_to_own_content" },
  { :method => "toggle_selected_for_preservation_to_own_content" },
  { :method => "toggle_univ_record_to_own_content" },
  { :method => "toggle_possible_univ_record_to_own_content" },
  { :method => "toggle_description" },
  { :method => "toggle_description_to_own_content" },
  { :method => "toggle_copyright" },
  { :method => "toggle_copyright_to_own_content" }, 
  { :method => "toggle_terms" },
  { :method => "toggle_terms_to_own_content" },
  { :method => "toggle_tags" }, 
  { :method => "toggle_tags_to_own_content" },
  { :method => "toggle_disposition" },
  { :method => "toggle_disposition_to_own_content" },
  { :method => "toggle_open" },
  { :method => "toggle_open_to_own_content" },
  { :method => "toggle_partially_open" },
  { :method => "toggle_partially_open_to_own_content" },
  { :method => "toggle_dark" },
  { :method => "toggle_dark_to_own_content" },
  { :method => "delete_items" },
  { :method => "delete_item_to_own_content" },
  { :method => "view_items" }, 
  { :method => "view_items_to_own_content" },
  { :method => "view_preserved_flag_content" }])
(ri1, ri2, ri3, ri4, ri5, ri6, ri7, ri8, ri9, ri10,
 ri11, ri12, ri13, ri13, ri15, ri16, ri17, ri18, ri19, ri20,
 ri21, ri22, ri23, ri24, ri25, ri26, ri27, ri28, ri29, ri30,
 ri31) = Right.all

r1.rights = Right.all
r1.save
r2.rights = [ri1, ri2, ri3]
r2.save
r3.rights = [ri4, ri5]
r3.save
r4.rights = [ri6, ri7, ri8, ri9, ri10]
r4.save

u1.roles = [r2, r3, r4]
u1.save

=begin
puts "Generating stored files"
40.times do
	StoredFile.create([{:original_filename => "file_#{rand(36**8).to_s(36)}", :user_id => u1.id, :access_level_id => a1.id, :content_type_id => c1.id},
					   {:original_filename => "file_#{rand(36**8).to_s(36)}", :user_id => u1.id, :access_level_id => a2.id, :content_type_id => c1.id},
					   {:original_filename => "file_#{rand(36**8).to_s(36)}", :user_id => u2.id, :access_level_id => a1.id, :content_type_id => c1.id},
					   {:original_filename => "file_#{rand(36**8).to_s(36)}", :user_id => u3.id, :access_level_id => a1.id, :content_type_id => c2.id}]) 
end

puts "Generating licenses"
License.create([{ :name => 'CC BY' },
				{ :name => 'CC BY-SA' },
				{ :name => 'CC BY-ND' },
				{ :name => 'CC BY-NC' },
				{ :name => 'CC BY-NC-SA' },
				{ :name => 'CC BY-NC-ND' }])

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
