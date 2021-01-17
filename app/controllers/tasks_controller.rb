class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:name].present? && params[:task_status].present?
      @tasks = Task.get_by_title(params[:name]).get_by_task_status(params[:task_status]).page(params[:page]).per(5)
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
    if params[:back]
      @task = Task.new(task_params)
    else
      @task = Task.new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{task.name}」を更新しました"
  end

  def create
    task = Task.new(task_params)
    task.save!
    redirect_to tasks_url, notice: "タスク「#{task.name}」を完了しました。"
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to tasks_url, notice: "タスク「#{task.name}」を消去しました"
  end

  private
  def task_params
    params.require(:task).permit(:name, :task_limit_on, :task_status, :priority)
  end
end
