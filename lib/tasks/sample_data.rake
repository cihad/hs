require 'faker'

namespace :db do
  desc "Populate database with sample data"
  task :sample_data, [:node_count] do |t, args|
    Integer(args[:node_count]).times do
      n = Node.create(
        title: Faker::Name.title,
        body:  Faker::Lorem.paragraphs.join("\n\n")
      )
      n.review!
      n.accept!
      puts n.inspect
    end

    puts "Created #{args[:node_count]} node"
  end
end