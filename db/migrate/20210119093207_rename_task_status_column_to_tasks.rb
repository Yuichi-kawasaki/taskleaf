class RenameTaskStatusColumnToTasks < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :task_status, :status
  end
end
