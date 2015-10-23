class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :layout_by_resource
  before_action :authenticate_user!
  add_breadcrumb "home", :root_path

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def layout_by_resource
    if devise_controller?
      "login"
    else
      "application"
    end
  end

  private

  def user_not_authorized
    flash[:error] = 'Você não tem permissão para fazer esta ação'
    redirect_to '/dashboard/clear'
  end

end
