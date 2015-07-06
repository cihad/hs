class ProductPolicy < ContentPolicy

  def permitted_attributes
    # Product attributes
    attrs = [:title, :body, :body_widgets]
    
    # Add attributes for policy
    node_attrs = { node_attributes: [:id, tag_list: []] }
    node_attrs[:node_attributes] << :status if current_user.manager?

    attrs << node_attrs

    # Return attributes
    attrs
  end

end