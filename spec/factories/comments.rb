# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    author nil
    node nil
    body "MyText"
  end
end
