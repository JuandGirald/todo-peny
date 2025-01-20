class TasksController < ApplicationController
  before_action :set_task, only: [:update, :destroy]

  def index
    @tasks = Task.order(start_time: :desc)
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
            turbo_stream.replace(@task, partial: "tasks/task", locals: { task: @task }),
            turbo_stream.update("task_modal", ""),
            turbo_stream.update("flash_messages", partial: "shared/flash", locals: { message: "Task updated successfully", type: "success" })
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

  def task_params
    params.require(:task).permit(:title, :description, :project_name, :start_time, :end_time, :status)
  end
end
