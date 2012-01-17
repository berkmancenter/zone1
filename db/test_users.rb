User.transaction do

  puts "Generating users"
  (user_steph, user_bgadoury, user_etann, user_brianb, user_user) = User.create([{ :email => 'steph@endpoint.com', :password => 'berkman', :password_confirmation => 'berkman', :name => 'Steph' },
               {:email => 'bgadoury@endpoint.com', :password => 'berkman', :password_confirmation => 'berkman', :name => 'Phunk' },
               {:email => 'etann@endpoint.com', :password => 'berkman', :password_confirmation => 'berkman', :name => 'Evan' },
               {:email => 'brianb@endpoint.com', :password => 'berkman', :password_confirmation => 'berkman', :name => 'Brian' },
               {:email => "user@endpoint.com", :password => "berkman", :password_confirmation => "berkman", :name => "User"}])


  puts "Generating groups"
  Group.create([{ :name => "Test 1" },
                { :name => "Test 2" },
                { :name => "Test 3" },
                { :name => "Test 4" }])
  (g1, g2, g3, g4) = Group.all

  Membership.add_users_to_groups([user_bgadoury, user_etann, user_user], [g1])
  Membership.add_users_to_groups([user_steph, user_brianb], [g1,g2], :is_owner => true)

  Membership.add_users_to_groups([user_bgadoury, user_user], [g2])

  Membership.add_users_to_groups([user_bgadoury], [g3,g4])
  Membership.add_users_to_groups([user_steph], [g3,g4], :is_owner => true)

  role_admin = Role.find_by_name "admin"

  # User role is automatically assigned to all users
  user_steph.roles << role_admin
  user_bgadoury.roles << role_admin
  user_brianb.roles << role_admin

end
