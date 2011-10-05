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

AccessLevel.create(:name => 'open', :display => 'Open')
AccessLevel.create(:name => 'dark', :display => 'Dark')
a = AccessLevel.new(:name => 'partially_open', :display => 'Partially Open')
a.save

Flag.create([{ :name => 'NOMINATED_FOR_PRESERVATION', :display => 'Nominated for Preservation' },
  { :name => 'SELECTED_FOR_PRESERVATION', :display => 'Selected for Preservation' },
  { :name => 'PRESERVED', :display => 'Preserved' },
  { :name => 'MAY_BE_UNIVERSITY_RECORD', :display => 'May be University Record' },
  { :name => 'UNIVERSITY_RECORD', :display => 'University Record' }])

c = ContentType.new(:name => "image")
c.save

User.create([{ :email => 'steph@endpoint.com', :password => 'berkman', :password_confirmation => 'berkman', :name => 'Steph' },
             {:email => 'bgadoury@endpoint.com', :password => 'berkman', :password_confirmation => 'berkman', :name => 'Phunk' },
             {:email => 'etann@endpoint.com', :password => 'berkman', :password_confirmation => 'berkman', :name => 'Evan' }])

g = Group.new(:name => 'End Point', :user_id => User.first.id)
g.users << User.all
g.save
