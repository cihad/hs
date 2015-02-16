require 'ostruct'

module NewIdeasHelper

  def idea_body username: Faker::Internet.user_name,
                user_image: random_avatar_image,
                &block

    render  layout: 'new_ideas/body',
            locals: {
              username: username, 
              user_image: user_image 
              }, 
            &block
  end

  def idea_comment  user_image: "user.jpg",
                    username: Faker::Internet.user_name,
                    &block

    render  layout: 'new_ideas/comment',
            locals: { 
              user_image: user_image, 
              username: username 
              }, 
            &block
  end

  def random_avatar_image
    user_attrs = JSON.parse(Net::HTTP.get_response(URI.parse('http://uifaces.com/api/v1/random')).body)
    user_attrs["image_urls"]["bigger"]
  end
end