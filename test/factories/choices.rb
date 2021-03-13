FactoryBot.define do
  factory :choice do
    option_1 { '選択肢ひとつめ' }
    option_2 { '選択肢ふたつめ' }
    association :user
  end
end
