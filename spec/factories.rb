IMAGES_DIR = "#{Rails.root}/spec/support/images"

FactoryGirl.define do
  factory :user, aliases: [:author] do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name } 
    username { Faker::Internet.user_name 4..20, %w(_) }
    email { Faker::Internet.email }
    password "123456"
    password_confirmation "123456"
  end

  factory :node do
    title Faker::Name.title
    body  Faker::Lorem.paragraphs.join("\n\n")
    author 

    factory :node_with_images do
      after(:create) do |node, evaluator|
        create_list :node_image, 4, node: node
      end
    end

    factory :node_with_tags do
      after(:create) do |node, evaluator|
        create_list :tagging, 3, taggable: node
      end
    end
  end

  factory :node_image do
    node
    image
  end

  factory :image do
    title Faker::Name.title
    sequence :image do |n|
      n = (n % 4) + 1
      File.new("#{IMAGES_DIR}/sample_image_#{n}.jpg")
    end
  end

  factory :tagging do
    tag
    association :taggable, factory: :node
  end

  factory :tag do
    sequence(:name) { |n| "tag#{n}" }
  end

end