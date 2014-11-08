IMAGES_DIR = "#{Rails.root}/spec/support/images"

FactoryGirl.define do
  factory :node do
    title Faker::Name.title
    tldr  Faker::Lorem.paragraph
    body  Faker::Lorem.paragraphs.join("\n\n")

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