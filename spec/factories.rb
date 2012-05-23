FactoryGirl.define do
  factory :user do
    name 'John'
    sequence(:email) {|n| "jdoe_#{n}@gmail.com" }
    password 'abcdefg'
    password_confirmation 'abcdefg'
  end

  factory :access_level do
    sequence(:name) { |n| "access level #{n}" }
    label 'test_label'
  end

  factory :flag do
    name 'test_flag'
    label 'test_label'
    factory :preserved_flag do
      name "NOMINATED_FOR_PRESERVATION"
    end
    factory :selected_flag do
      name "SELECTED_FOR_PRESERVATION"
    end
  end

  factory :groups_stored_file do
    stored_file
    group    
  end

  factory :group do
    sequence(:name) {|n| "Group ##{n}" }
    factory :group_with_owner do
      after(:create) do |group|
        FactoryGirl.create(:membership_as_owner, :group => group)
        group.reload
      end
    end
  end

  factory :mime_type_category do
    name "MyString"
  end

  factory :mime_type do
    name "TestName"
    mime_type "test/mime_type"
    extension ".test"
    mime_type_category
  end

  factory :membership do
    user
    group 
    factory :confirmed_membership do
      joined_at Time.now
      factory :membership_as_owner do
        is_owner true
      end
    end
  end

  factory :license do
    sequence(:name) { |n| "test_license_#{n}" }
  end

  factory :role do
    sequence(:name) {|n| "Role ##{n}" }
  end

  factory :right do
    action 'test_right'
    description 'test_description'
  end

  factory :right_assignment do
    subject_type 'test_right_assignment'
  end

  factory :stored_file do
    original_filename 'test_stored_file'
    user
    access_level
    license
  end

  factory :comment do
    content 'test comment 1'
    stored_file
    user
  end

  factory :flagging do
    flag
    stored_file
    user
  end

  factory :preference do
    sequence(:name) {|n| "pref_name#{n}" }
    sequence(:label) {|n| "Pref Label Number #{n}" }
    sequence(:value) {|n| "pref_value#{n}" }
    factory :sftp_user_home_directory_root do
      name "sftp_user_home_directory_root"
      label "SFTP User Home Directory Root (Absolute Path)"
      value "/tmp"
    end
    factory :default_user_upload_quota do
      name "default_user_upload_quota"
      label "User Quota Label"
      value "987654321"
    end
    factory :fits_script_path do
      name "fits_script_path"
      label "FITS script path label"
      value "/usr/local/bin/fits/fits.sh"
    end
    factory :group_invite_from_address do
      name "group_invite_from_address"
      label "Group Invite Email From Address"
      value "group_invites@zoneone.domain"
    end
  end

  factory :sftp_user do
    user
  end
end
