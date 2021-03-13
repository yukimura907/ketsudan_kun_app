class User < ApplicationRecord
  authenticates_with_sorcery!

  # validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  # validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  # validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :name, presence: true, uniqueness: true, length: { maximum: 15 }

  has_many :choices, foreign_key: :user_id, dependent: :destroy
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  def count_all_choices
    choices.count
  end

  def count_today_choices
    from = Time.current.beginning_of_day
    to = Time.current.end_of_day
    choices.all.where(created_at: from...to).count
  end

  def how_often?
    if count_all_choices > 20
      'あまりにも優柔不断。たまには自分で決断せよ'
    elsif count_all_choices > 10 && count_all_choices <= 20
      '少し意思が弱くはないか？'
    else
      '人並みである。安心せよ。'
    end
  end
end
