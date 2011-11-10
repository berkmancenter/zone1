FactoryGirl.define do
  factory :user do
    name 'John'
    email 'jdoe@gmail.com'
    password 'abcdefg'
    password_confirmation 'abcdefg'
  end

  factory :access_level do
    name 'test_access_level'
    label 'test_label'
  end

  factory :content_type do
    name 'test_content_type'
  end

  factory :flag do
    name 'test_flag'
    label 'test_label'
  end

  factory :group do
    name 'test_group'
  end

  factory :license do
    name 'test_license'
  end

  factory :role do
    name 'test_role'
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
    user_id '1'
    access_level_id '1'
    content_type_id '1'
  end

  factory :flagging do
    flag_id '1'
    stored_file_id '1'
    user_id '1'
  end
end
