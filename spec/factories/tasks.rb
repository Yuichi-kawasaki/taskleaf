FactoryBot.define do
  factory :task do
    name { 'task' }
    task_limit_on { '2020-12-12' }
    task_status { '済' }
  end

  factory :second_task, class: Task do
    name { 'task2' }
    task_limit_on { '2020-12-22' }
    task_status { '未' }
  end
end
