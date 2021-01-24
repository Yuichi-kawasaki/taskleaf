class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, {presence: true, length: { maximum: 255 },
  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }}

  before_validation { email.downcase! }
  before_destroy :admin_zero
  before_update  :admin_authorization

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  has_many :tasks, foreign_key: :user_id, dependent: :destroy
  # enum admin: { user: 0, admin: 1 }


  private

  def admin_authorization
  end

  def admin_zero
    if User.where(admin: true).length == 1 && self.admin?
      throw(:abort)
    end
  end
end
