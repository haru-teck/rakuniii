class User < ApplicationRecord
  # Deviseのモジュール
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ActiveHashとの関連付け
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :role

  # バリデーション
  validates :name, presence: true, uniqueness: { scope: :role_id }
  validates :role_id, presence: true

  # Deviseのemailを無効化
  def email_required?
    false
  end

  def will_save_change_to_email?
    false
  end
end


