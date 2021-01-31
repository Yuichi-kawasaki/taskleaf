class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.order(id: "DESC")

    if params[:task].present?

      @tasks = @tasks.get_by_name(params[:task][:name])
      @tasks = @tasks.get_by_status(params[:task][:status]) if params[:task][:status].present?
    end
    @tasks = @tasks.order(limit_on: "DESC") if params[:sort_expired]
    @tasks = @tasks.order(priority: "DESC") if params[:sort_priority]

    @tasks.page(params[:page]).per(5)
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスクを作成しました！"
    else
      render :new
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました！"
  end

  private
  def task_params
    params.require(:task).permit(:name, :limit_on, :status, :priority)
  end
  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
