class RecreateImageThumbnailVersions < ActiveRecord::Migration
  def change
    Image.find_each do |image|
      image.image.recreate_versions! if image.image?
    end
  end
end
