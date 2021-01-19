class RenameTaskLimitOnColumnToTasks < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :task_limit_on, :limit_on
  end
end
