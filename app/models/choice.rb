class Choice < ApplicationRecord
  validates :title, length: { maximum: 15 }, presence: true
  validates :option_1, length: { maximum: 15 }, presence: true
  validates :option_1, length: { maximum: 15 }, presence: true

  belongs_to :user
end
