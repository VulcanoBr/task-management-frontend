class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_user, :user_signed_in?
  before_action :authenticate_user!

  def current_user
    return nil unless session[:token] && session[:user]
    @current_user ||= session[:user]
  end

  def user_signed_in?
    current_user.present?
  end

  def authenticate_user!
    unless user_signed_in?
      flash[:alert] = "Você precisa estar logado para acessar essa página."
      redirect_to login_path
    end
  end

  rescue_from ApiError do |exception|
    flash[:alert] = "Erro na API: #{exception.errors}"
    redirect_to root_path
  end

end
