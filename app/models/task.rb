class Task < ApplicationRecord
  validates :name, presence: true
  validates :limit_on, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  validates :name, length: {maximum: 30}

  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings

  enum status: { 未着手: 0, 着手中: 1, 完了: 2 }
  enum priority: { 選択して下さい: 0, 低: 1, 中: 2, 高: 3 }


  scope :get_by_name, -> (name) {
    where('name LIKE ?', "%#{ name }%")
  }

  scope :get_by_status, -> (status) {
    where(status: status)
  }

  scope :get_by_priority, -> (priority) {
    where(priority: priority)
  }

  scope :get_by_labels_id, -> (label){
    where('id LIKE?', "%#{title}%")
  }

end
