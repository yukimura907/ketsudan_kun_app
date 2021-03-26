FactoryBot.define do
  factory :choice do
    title { 'テストお題' }
    option_1 { '選択肢ひとつめ' }
    option_2 { '選択肢ふたつめ' }
    result { '選択肢ひとつめ' }
    association :user

    trait :today do
      created_at { Time.current }
    end

    trait :yesterday do
      created_at { Time.current.yesterday }
    end

    trait :without_title_and_result do
      title { nil }
      result { nil } 
    end

  end
end
