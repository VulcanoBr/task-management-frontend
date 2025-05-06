class HomeController < ApplicationController
  def index
    begin
      @projects = ProjectService.new(session[:token]).all
    rescue ApiError => e
      @projects = []
      flash.now[:alert] = "Não foi possível carregar os projetos: #{e.errors}"
    end
  end
end
