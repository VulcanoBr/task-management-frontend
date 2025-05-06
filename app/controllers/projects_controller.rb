class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    begin
      @projects = ProjectService.new(session[:token]).all
    rescue ApiError => e
      @projects = []
      flash.now[:alert] = "Não foi possível carregar os projetos: #{e.errors}"
    end
  end

  def show
    begin
      @tasks = TaskService.new(session[:token]).all(@project['id'])
    rescue ApiError => e
      @tasks = []
      flash.now[:alert] = "Não foi possível carregar as tarefas deste projeto: #{e.errors}"
    end
  end

  def new
  end

  def create
    begin
      @project = ProjectService.new(session[:token]).create(project_params)
      flash[:notice] = "Projeto criado com sucesso!"
      redirect_to projects_path
    rescue ApiError => e
      flash.now[:alert] = "Não foi possível criar o projeto: #{e.errors}"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    begin
      @project = ProjectService.new(session[:token]).update(@project['id'], project_params)
      flash[:notice] = "Projeto atualizado com sucesso!"
      redirect_to project_path(@project['id'])
    rescue ApiError => e
      flash.now[:alert] = "Não foi possível atualizar o projeto: #{e.errors}"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      ProjectService.new(session[:token]).destroy(@project['id'])
      flash[:notice] = "Projeto excluído com sucesso!"
      redirect_to projects_path
    rescue ApiError => e
      flash[:alert] = "Não foi possível excluir o projeto: #{e.errors}"
      redirect_to projects_path
    end
  end

  private

  def set_project
    begin
      project_id = params[:id]
      @project = ProjectService.new(session[:token]).find(project_id)
    rescue ApiError => e
      flash[:alert] = "Projeto não encontrado: #{e.errors}"
      redirect_to projects_path
    end
  end

  def project_params
    params.require(:project).permit(:name, :description, :start_date, :end_date, :status)
  end
end
