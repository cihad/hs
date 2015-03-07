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
      n = Node.create do |n|
        n.title   = Faker::Name.title
        n.body    = Faker::Lorem.paragraphs.join("\n\n")
        n.author  = User.offset(rand(0..(User.count - 1))).first
        n.status  = "published"
      end

      puts n.inspect
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