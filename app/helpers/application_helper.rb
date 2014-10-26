module ApplicationHelper

  def is_active_page_current?
    current_page?({
      controller: controller_name,
      action:     action_name
    })
  end

end
