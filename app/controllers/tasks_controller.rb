class TasksController < ApplicationController
  before_action :set_task, only: [:update, :destroy]

  def index
    @tasks = filtered_tasks
  end

  def new
    @task = Task.new
    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("task_modal", 
          partial: "tasks/form", 
          locals: { task: @task }
        )
      end
    end
  end

  def edit
    @task = Task.find(params[:id])
    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("task_modal", 
          partial: "tasks/form", 
          locals: { task: @task }
        )
      end
    end
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update("tasks_list", partial: "tasks/task_list", locals: { tasks: Task.all }),
            turbo_stream.update("tabs", partial: "tasks/tabs"),
            turbo_stream.update("task_modal", ""),
            turbo_stream.update("flash_messages",
              partial: "shared/flash",
              locals: { message: "Task was successfully created", type: "success" }
            )
          ]
        end
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("task_modal",
            partial: "tasks/form",
            locals: { task: @task }
          )
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(@task),
            turbo_stream.update("tasks_list", partial: "tasks/task_list", locals: { tasks: filtered_tasks }),
            turbo_stream.update("tabs", partial: "tasks/tabs"),
            turbo_stream.update("task_modal", ""),
            turbo_stream.update("flash_messages",
              partial: "shared/flash",
              locals: { message: "Task was successfully updated", type: "success" }
            )
          ]
        end
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("task_modal",
            partial: "tasks/form",
            locals: { task: @task }
          )
        end
      end
    end
  end

  def destroy
    @task.destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update("tasks_list", partial: "tasks/task_list", locals: { tasks: Task.all }),
          turbo_stream.update("tabs", partial: "tasks/tabs"),
          turbo_stream.update("flash_messages",
            partial: "shared/flash",
            locals: { message: "Task deleted successfully", type: "success" }
          )
        ]
      end
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def filtered_tasks
    tasks = case params[:status]
      when 'open'
        Task.open
      when 'completed'
        Task.completed
      else
        Task.all
      end

    case params[:sort_by]
    when 'title'
      tasks.order(title: :asc)
    when 'project'
      tasks.order(project_name: :asc)
    when 'start_time'
      tasks.order(start_time: :desc)
    when 'created_at'
      tasks.order(created_at: :desc)
    else
      tasks.order(created_at: :desc) # default sorting
    end
  end

  def task_params
    params.require(:task).permit(:title, :description, :project_name, :start_time, :end_time, :status)
  end
end
