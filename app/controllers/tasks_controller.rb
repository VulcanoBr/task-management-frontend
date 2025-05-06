class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    begin
      @tasks = TaskService.new(session[:token]).all(@project['id'])
      redirect_to project_path(@project['id'])
    rescue ApiError => e
      flash[:alert] = "Não foi possível carregar as tarefas: #{e.errors}"
      redirect_to projects_path
    end
  end

  def show
    redirect_to project_path(@project['id'])
  end

  def new
    # Apenas renderiza o formulário
  end

  def create
    begin
      @task = TaskService.new(session[:token]).create(@project['id'], task_params)
      flash[:notice] = "Tarefa criada com sucesso!"
      redirect_to project_path(@project['id'])
    rescue ApiError => e
      flash.now[:alert] = "Não foi possível criar a tarefa: #{e.errors}"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # Apenas renderiza o formulário com a tarefa atual
  end

  def update
    begin
      @task = TaskService.new(session[:token]).update(@project['id'], @task['id'], task_params)
      flash[:notice] = "Tarefa atualizada com sucesso!"
      redirect_to project_path(@project['id'])
    rescue ApiError => e
      flash.now[:alert] = "Não foi possível atualizar a tarefa: #{e.errors}"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      TaskService.new(session[:token]).destroy(@project['id'], @task['id'])
      flash[:notice] = "Tarefa excluída com sucesso!"
      redirect_to project_path(@project['id'])
    rescue ApiError => e
      flash[:alert] = "Não foi possível excluir a tarefa: #{e.errors}"
      redirect_to project_path(@project['id'])
    end
  end

  private

  def set_project
    begin
      project_id = params[:project_id]
      @project = ProjectService.new(session[:token]).find(project_id)
    rescue ApiError => e
      flash[:alert] = "Projeto não encontrado: #{e.errors}"
      redirect_to projects_path
    end
  end

  def set_task
    begin
      task_id = params[:id]
      @task = TaskService.new(session[:token]).find(@project['id'], task_id)
    rescue ApiError => e
      flash[:alert] = "Tarefa não encontrada: #{e.errors}"
      redirect_to project_path(@project['id'])
    end
  end

  def task_params
    task_parameters = params.require(:task).permit(:name, :percentage, :user_id)
    # Se o user_id não for fornecido, usar o ID do usuário atual
    task_parameters[:user_id] ||= current_user["id"]
    task_parameters
  end
end
