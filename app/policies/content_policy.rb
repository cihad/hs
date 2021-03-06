class ContentPolicy < Struct.new(:current_user, :content)

  def new?
    create?
  end

  def update?
    content.node.owner?(current_user) or current_user.chef?(content.node.author)
  end

  def edit?
    update?
  end

  def create?
    current_user.is_greater_than? :anonymous
  end

  def destroy?
    content.node.owner?(current_user) or current_user.manager?
  end

  def permitted_attributes
    # Content attributes
    attrs = [:title, :body, :body_widgets]
    
    # Add attributes for policy
    node_attrs = { node_attributes: [:id, tag_list: []] }
    node_attrs[:node_attributes] << :status if current_user.manager?

    # Add nested attributes to content attributes
    attrs << node_attrs

    # Return attributes
    attrs
  end

end