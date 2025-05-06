class DashboardController < ApplicationController
  def index
    begin
      @projects = ProjectService.new(session[:token]).all

      # Estatísticas básicas
      @total_projects = @projects.size
      @completed_projects = @projects.count { |p| p['status'] == 'concluido' }
      @in_progress_projects = @projects.count { |p| p['status'] == 'em_andamento' }
      @pending_projects = @projects.count { |p| p['status'] != 'concluido' && p['status'] != 'em_andamento' }

      # Buscar tarefas para cada projeto para mostrar progresso geral
      @tasks_count = 0
      @completed_tasks = 0

      @projects.each do |project|
        begin
          tasks = TaskService.new(session[:token]).all(project['id'])
          @tasks_count += tasks.size
          @completed_tasks += tasks.count { |t| t['percentage'] == 100 }
        rescue ApiError
          # Ignorar erros ao buscar tarefas para não interromper o dashboard
        end
      end
    rescue ApiError => e
      @projects = []
      flash.now[:alert] = "Não foi possível carregar os dados do dashboard: #{e.errors}"
    end
  end
end
