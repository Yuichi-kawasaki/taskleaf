class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:name].present? && params[:task_status].present?
      @tasks = Task.get_by_name(params[:name]).get_by_task_status(params[:task_status]).page(params[:page]).per(5)
    elsif params[:name].present?
      @tasks = Task.get_by_name(params[:name]).page(params[:page]).per(5)
    elsif params[:task_status].present?
      @tasks = Task.get_by_task_status(params[:task_status]).page(params[:page]).per(5)
    elsif params[:sort_expired]
      @tasks = Task.order(task_limit_on: "DESC").page(params[:page]).per(5)
    elsif params[:sort_priority]
      @tasks = Task.order(priority:"DESC").page(params[:page]).per(5)
    else
      @tasks = Task.order(id: "DESC").page(params[:page]).per(5)
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def create
    @task = Task.new(task_params)
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
    params.require(:task).permit(:name, :task_limit_on, :task_status, :priority)
  end
  def set_task
    @task = Task.find(params[:id])
  end
end
