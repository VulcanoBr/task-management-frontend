class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  layout 'auth'

  def new
    redirect_to root_path if user_signed_in?
  end

  def create
    begin
      result = AuthService.new.login(params[:session][:email], params[:session][:password])
      session[:token] = result['token']

      # Decodificar o token para obter o user_id
      decoded_token = JWT.decode(result['token'], nil, false).first
      user_id = decoded_token['user_id']

      # Armazenar informações básicas do usuário na sessão para não precisar consultar a API a cada requisição
      session[:user] = { id: user_id, email: params[:session][:email] }

      flash[:notice] = "Login realizado com sucesso!"
      redirect_to root_path
    rescue ApiError => e
      flash.now[:alert] = "E-mail ou senha inválidos."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:token)
    session.delete(:user)
    flash[:notice] = "Logout realizado com sucesso!"
    redirect_to login_path
  end
end
