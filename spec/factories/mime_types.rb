# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mime_type do
    name "TestName"
    mime_type "test/mime_type"
    extension ".test"
    mime_type_category
  end
end
