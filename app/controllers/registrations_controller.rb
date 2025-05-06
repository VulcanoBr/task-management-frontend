class RegistrationsController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'auth'

  def new
    redirect_to root_path if user_signed_in?
  end

  def create
    begin
      AuthService.new.sign_up(params[:user][:email], params[:user][:password])
      flash[:notice] = "Cadastro realizado com sucesso! Faça login para continuar."
      redirect_to login_path
    rescue ApiError => e
      flash.now[:alert] = "Não foi possível realizar o cadastro: #{e.errors}"
      render :new, status: :unprocessable_entity
    end
  end
end
