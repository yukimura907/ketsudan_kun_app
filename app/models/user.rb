class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true
  validates :email, presence: true
  validates :name, presence: true, length: { maximum: 255 }

  has_many :choices

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
      'とんでもなく優柔不断。たまには自分で決断せよ'
    elsif count_all_choices > 10 && count_all_choices <= 20
      'まぁまぁ優柔不断だが許容範囲'
    else
      '人並みに優柔不断。安心せよ。'
    end
  end
end
