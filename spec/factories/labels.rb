FactoryBot.define do
  factory :label do
    title {'新規'}
    # after(:build) do |label|
    #   label.task = FactoryBot.create(:task)
    # end
  end
  factory :label2, class: Label do
    title {'リピート'}
  end

  factory :label3, class: Label do
    title {'修理'}
  end
end
