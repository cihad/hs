class NodePolicy < Struct.new(:current_user, :node)

  def new?
    create?
  end

  def update?
    node.owner?(current_user) or current_user.chef?(node.author)
  end

  def edit?
    update?
  end

  def create?
    current_user.is_greater_than? :anonymous
  end

  def destroy?
    node.owner?(current_user) or current_user.manager?
  end

  def permitted_attributes
    attrs = [
      :title,
      :body,
      :tag_list,
      node_images_attributes: [
        :_destroy,
        :id,
        image_attributes: [
          :id,
          :image,
          :title
        ]
      ]
    ]
    attrs.push(:status) if current_user.manager?
    attrs
  end

end