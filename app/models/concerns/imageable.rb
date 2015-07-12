module Imageable
  extend ActiveSupport::Concern

  included do
    has_many :images, as: :imageable
    after_save :save_images
  end

  def save_images
    if self.class.column_names.include? "body_widgets"
      arr = JSON.parse body_widgets
      
      select_image_widgets arr      

      arr.select { |widget| widget.name == "Grid" }.each do |grid|
        select_image_widgets grid.config.columns
      end
    end
  end

  def select_image_widgets arr
    arr.select { |widget| widget.name == "Image" }.each do |image_widget|
      add_imageable_to_image image_widget
    end
  end

  def add_imageable_to_image image_widget
    image = Image.find_by image: image_widget.value.url.split('/').last
    if image and !image.imageable
      image.imageable = self 
      image.save
    end
  end

end