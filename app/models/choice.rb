class Choice < ApplicationRecord
  validates :title, length: { maximum: 15 }, presence: true
  validates :option_1, length: { maximum: 15 }, presence: true
  validates :option_2, length: { maximum: 15 }, presence: true
  validates :option_3, length: { maximum: 15 }
  validates :option_4, length: { maximum: 15 }
  validates :option_5, length: { maximum: 15 }
  validates :result, length: { maximum: 15 }


  belongs_to :user

  before_validation :set_choice_title

  private

  def set_choice_title
    self.title = 'なし' if title.blank?
  end
end
