class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Devise permitted parameters
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Pundit
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


  helper_method :comment_path
  def comment_path comment
    node_path comment.node, anchor: "comment_#{comment.id}"
  end

  def current_user
    @current_user ||= super || AnonymousUser.new(role: "anonymous")
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << [:name, :username]
    devise_parameter_sanitizer.for(:sign_up) << [:name, :username]
  end

  private

  def user_not_authorized
    messages = [I18n.t('authorization.no_access')]

    if current_user.registered?
      redirect_path = root_path
    else
      messages << I18n.t('authorization.try_login')
      redirect_path = new_user_session_path
    end

    flash[:alert] = messages.join(" ")

    redirect_to(request.referrer || redirect_path)
  end
end
