module Imageable
  extend ActiveSupport::Concern

  included do
    has_many :images, as: :imageable, dependent: :destroy
    after_save :save_images
  end

  def image_widget_file_names
    @image_widget_file_names ||= []
  end

  def save_images
    if self.class.column_names.include? "body_widgets"
      arr = JSON.parse body_widgets
      
      select_image_widgets arr

      arr.select { |widget| widget["name"] == "Grid" }.each do |grid|
        select_image_widgets grid["config"]["columns"]
      end

      images.each do |img|
        img.destroy unless image_widget_file_names.include? img["image"]
      end
    end
  end

  def select_image_widgets arr
    arr.select { |widget| widget["name"] == "Image" }.each do |image_widget|
      add_imageable_to_image image_widget
    end
  end

  def add_imageable_to_image image_widget
    file_name = get_filename_from_url image_widget["value"]["url"]
    image_widget_file_names << file_name
    image = Image.find_by image: file_name
    if image and !image.imageable
      image.imageable = self 
      image.save
    end
  end

  def get_filename_from_url url
    url.split('/').last
  end

end