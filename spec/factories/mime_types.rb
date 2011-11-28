# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mime_type do
    name "MyString"
    mime_type "MyString"
    extension "MyString"
    mime_type_category
  end
end
