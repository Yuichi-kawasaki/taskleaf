FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    name { 'task1' }
    limit_on { '2020-11-12' }
    status { '未着手' }
    priority {'低'}
  end

  factory :second_task, class: Task do
    name { 'task2' }
    limit_on { '2020-12-22' }
    status { '完了' }
    priority {'高'}
  end
end
