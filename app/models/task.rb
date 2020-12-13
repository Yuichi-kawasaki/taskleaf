class Task < ApplicationRecord
  validates :name, presence: true
  validates :name, length: {maximum: 30}


  private
  def validate_name_not_including_comma
    errors.add(:name, 'にカンマを含める事はできません') if name&.including?(',')
  end
end
