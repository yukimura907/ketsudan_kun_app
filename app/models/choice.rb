class Choice < ApplicationRecord
  validates :title, length: { maximum: 15 }, presence: true
  validates :option_1, length: { maximum: 15 }, presence: true
  validates :option_2, length: { maximum: 15 }, presence: true
  validates :result, length: { maximum: 15 }

  belongs_to :user

  before_validation :set_choice_title

  private

  def set_choice_title
    self.title = 'なし' if title.blank?
  end
end
