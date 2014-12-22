class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Devise permitted parameters
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Pundit
  include Pundit

  helper_method :comment_path
  def comment_path comment
    node_path comment.node, anchor: "comment_#{comment.id}"
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << [:first_name, :last_name, :username]
    devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, :username]
  end
end
