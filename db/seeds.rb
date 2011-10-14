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

AccessLevel.create([{ :name => 'open', :label => 'Open' },
  { :name => 'dark', :label => 'Dark' },
  { :name => 'partially_open', :label => 'Partially Open' }])
(a1, a2, a3) = AccessLevel.all

Flag.create([{ :name => 'NOMINATED_FOR_PRESERVATION', :label => 'Nominated for Preservation' },
  { :name => 'SELECTED_FOR_PRESERVATION', :label => 'Selected for Preservation' },
  { :name => 'PRESERVED', :label => 'Preserved' },
  { :name => 'MAY_BE_UNIVERSITY_RECORD', :label => 'May be University Record' },
  { :name => 'UNIVERSITY_RECORD', :label => 'University Record' }])


ContentType.create([{ :name => "image" }, { :name => "doc" }])
(c1, c2) = ContentType.all

User.create([{ :email => 'steph@endpoint.com', :password => 'berkman', :password_confirmation => 'berkman', :name => 'Steph' },
             {:email => 'bgadoury@endpoint.com', :password => 'berkman', :password_confirmation => 'berkman', :name => 'Phunk' },
             {:email => 'etann@endpoint.com', :password => 'berkman', :password_confirmation => 'berkman', :name => 'Evan' }])
(u1, u2, u3) = User.all

g = Group.new(:name => 'End Point', :user_id => User.first.id)
g.users << User.all
g.save

40.times do
	StoredFile.create([{:original_file_name => "abx99", :user_id => u1.id, :access_level_id => a1.id, :content_type_id => c1.id},
					   {:original_file_name => "law", :user_id => u1.id, :access_level_id => a2.id, :content_type_id => c1.id},
					   {:original_file_name => "berk", :user_id => u2.id, :access_level_id => a1.id, :content_type_id => c1.id},
					   {:original_file_name => "berk2", :user_id => u3.id, :access_level_id => a1.id, :content_type_id => c2.id}]) 
end

StoredFile.all.each do |a|
  a.tag_list = "paper"
  a.save
  a.flags << Flag.first
end

sf = StoredFile.first
sf.tag_list = "dissertation"
sf.flags << Flag.last
sf.save

sf = StoredFile.last
sf.tag_list = "thesis"
sf.save 
