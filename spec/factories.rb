FactoryGirl.define do
  factory :user do
    name 'John'
    sequence(:email) {|n| "jdoe_#{n}@gmail.com" }
    password 'abcdefg'
    password_confirmation 'abcdefg'
    after_build do |user|
      #user's after_create callback expects a role with a name user 
      Factory.create(:role, :name => "user") unless Role.find_by_name("user").present?
    end
  end

  factory :access_level do
    sequence(:name) { |n| "access level #{n}" }
    label 'test_label'
  end

  factory :content_type do
    sequence(:name) { |n| "test_content_type #{n}" }
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

  factory :group do
    sequence(:name) {|n| "Group ##{n}" }
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
    content_type
  end

  factory :flagging do
    flag
    stored_file
    user
  end
end
