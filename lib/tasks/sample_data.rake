require 'faker'

namespace :db do
  desc "Populate database with sample data"
  task :sample_data, [:node_count] => [:environment] do |t, args|

    10.times do
      User.create do |u|
        u.name      = Faker::Name.name
        u.username  = Faker::Internet.user_name
        u.email     = Faker::Internet.email
        u.password  = "123456"
      end.inspect
    end

    Integer(args[:node_count]).times do
      c = Content.new do |c|
        c.title   = Faker::Name.title
        c.body    = Faker::Lorem.paragraphs.join("\n\n")
      end

      c.build_node author: User.offset(rand(0..(User.count - 1))).first,
        status: "published"

      c.save
      puts c.inspect
    end

    Node.all.each do |n|
      rand(10).times do
        Comment.create do |c|
          c.node    = n
          c.author  = User.offset(rand(0..(User.count - 1))).first
          c.body    = Faker::Lorem.paragraphs.join("\n\n")
        end.inspect
      end
    end

    puts "Created #{args[:node_count]} node"
  end
end