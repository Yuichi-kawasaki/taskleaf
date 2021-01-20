class ChangeColumnToTask < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :name, :string, null: false
    change_column :tasks, :task_limit_on, :date, null: false
    change_column :tasks, :task_status, :integer, null: false
  end
end
