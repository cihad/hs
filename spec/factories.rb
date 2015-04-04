images_directory = "#{Rails.root}/spec/support/images"

FactoryGirl.define do
  factory :user, aliases: [:author] do
    name { Faker::Name.name }
    username { Faker::Internet.user_name 4..20, %w(_) }
    email { Faker::Internet.email }
    password "123456"
    password_confirmation "123456"

    %i(anonymous authenticated admin superadmin).each do |role|
      factory role do
        role role.to_s
      end
    end
  end

  factory :content do
    transient do
      author nil
    end

    title Faker::Name.title
    body Faker::Lorem.paragraphs.join("\n\n")
    
    factory :content_with_images do
      after(:create) do |content, evaluator|
        create_list :content_image, 4, content: content
      end
    end

    after(:create) do |content, evaluator|
      content.node.update author: evaluator.author if evaluator.author
    end

    node
  end

  factory :node do
    title Faker::Name.title
    body Faker::Lorem.paragraphs.join("\n\n")
    author
    tag_list Faker::Lorem.words.join(",")
    status "awaiting_review"

    factory :published_node do
      status "published"
    end

    factory :node_with_tags do
      after(:create) do |node, evaluator|
        create_list :tagging, 3, taggable: node
      end
    end
  end

  factory :comment do
    author
    node
    body Faker::Lorem.paragraph
  end

  factory :content_image do
    content
    image
  end

  factory :image do
    title Faker::Name.title
    sequence :image do |n|
      n = (n % 4) + 1
      Rack::Test::UploadedFile.new("#{images_directory}/sample_image_#{n}.jpg", "image/jpg")
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