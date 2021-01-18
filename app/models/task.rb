class Task < ApplicationRecord
  validates :name, presence: true
  validates :task_limit_on, presence: true
  validates :task_status, presence: true
  validates :priority, presence: true
  validates :name, length: {maximum: 30}

  enum task_status: { 未着手: 0, 着手中: 1, 完了: 2 }
  enum priority: { 選択して下さい: 0, 低: 1, 中: 2, 高: 3 }

  scope :get_by_name, -> (name) { where('name LIKE ?', "%#{name}%")}
  scope :get_by_task_status, -> (task_status) { where(task_status: task_status)}
  scope :get_by_priority, -> (priority) { where(priority: priority)}
end
