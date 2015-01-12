class RegenerateNameFromUsers < ActiveRecord::Migration
  def up
    User.all.each do |user|
      name = "%s %s" % [user.name, user.last_name]
      user.update_attribute 'name', name
    end
  end

  def down3
    User.all.each do |user|
      last_name = user.name.split.last
      name = user.name.split[0..-2].join(' ')
      user.update_attribute 'last_name', last_name
      user.update_attribute 'name', name
    end
  end
end
