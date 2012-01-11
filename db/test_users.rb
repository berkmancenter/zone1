
puts "Generating users"
User.create([{ :email => 'steph@endpoint.com', :password => 'berkman', :password_confirmation => 'berkman', :name => 'Steph' },
             {:email => 'bgadoury@endpoint.com', :password => 'berkman', :password_confirmation => 'berkman', :name => 'Phunk' },
             {:email => 'etann@endpoint.com', :password => 'berkman', :password_confirmation => 'berkman', :name => 'Evan' },
             {:email => 'brianb@endpoint.com', :password => 'berkman', :password_confirmation => 'berkman', :name => 'Brian' },
             {:email => "user@endpoint.com", :password => "berkman", :password_confirmation => "berkman", :name => "User"}])
(user_steph, user_bgadoury, user_etann, user_brianb, user_user) = User.all


puts "Generating groups"
Group.create([{ :name => "End Point" },
              { :name => "Test 1" },
              { :name => "Test 2" },
              { :name => "Test 3" }])
(g1, g2, g3, g4) = Group.all

g1.users << User.all
g1.owners = [user_steph, user_brianb]
g2.users = [user_steph, user_bgadoury, user_brianb, user_user]
g2.owners = [user_steph, user_brianb]
g3.users = [user_steph, user_bgadoury]
g3.owners << user_steph
g4.users = [user_steph, user_bgadoury]
g4.owners << user_steph

role_admin = Role.find_by_name "admin"

# User role is automatically assigned to all users
user_steph.roles << role_admin
user_bgadoury.roles << role_admin
user_brianb.roles << role_admin
