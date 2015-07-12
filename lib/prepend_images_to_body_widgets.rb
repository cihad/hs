class PrependImagesToBodyWidgets

  def exec!
    Image.all.each do |image|
      content = image.imageable
      arr = JSON.parse content.body_widgets
      arr.unshift(as_json image)
      content.body_widgets = arr.to_json
      content.save
    end
  end

  def as_json image
    {
      name: "Image",
      machineName: "bootstrap/image",
      version: 1,
      value: {
        url: image.image_url,
        caption: image.title
      },
      config: {
        type: "thumbnail",
        caption: true
      }
    }
  end


end