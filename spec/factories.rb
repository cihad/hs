FactoryGirl.define do
  factory :node do
    title Faker::Name.title
    tldr  Faker::Lorem.paragraph
    body  Faker::Lorem.paragraphs.map { |p| "<p>#{p}</p>" }.join
  end
end