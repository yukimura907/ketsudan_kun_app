module ChoiceMacros
  def create_two_choice
    visit new_choice_path
    fill_in 'お題', with: 'テストお題'
    fill_in '一つ目の選択肢', with: 'テスト1' 
    fill_in '二つ目の選択肢', with: 'テスト2'
    click_on '確認する'
  end
end