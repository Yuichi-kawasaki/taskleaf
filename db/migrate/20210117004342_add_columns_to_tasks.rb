class AddColumnsToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :task_limit_on, :date
    add_column :tasks, :task_status, :integer
  end
end
