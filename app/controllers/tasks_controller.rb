class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:name].present? && params[:status].present?
      @tasks = current_user.tasks.get_by_name(params[:name]).get_by_status(params[:status]).page(params[:page]).per(5)
    elsif params[:name].present?
      @tasks = current_user.tasks..get_by_name(params[:name]).page(params[:page]).per(5)
    elsif params[:status].present?
      @tasks = current_user.tasks..get_by_status(params[:status]).page(params[:page]).per(5)
    elsif params[:sort_expired]
      @tasks = current_user.tasks..order(limit_on: "DESC").page(params[:page]).per(5)
    elsif params[:sort_priority]
      @tasks = current_user.tasks..order(priority:"DESC").page(params[:page]).per(5)
    else
      @tasks = current_user.tasks..order(id: "DESC").page(params[:page]).per(5)
    end
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
    @task = current_user.tasks.find(params[:id])
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
    @task = current_user.tasks.(params[:id])
  end
end
