require 'rails_helper'

RSpec.describe 'Choices', type: :system do
  let(:user){ create :user }
  describe 'ホーム画面表示のテスト' do
    context 'ログインしていない時' do
      it 'ホーム画面に、twitterでログイン、登録せず決断、の２種類のボタンがある' do
        visit root_path
        expect(page).to have_content 'Twitterでログイン'
        expect(page).to have_content '登録せずに決断！' 
      end
    end

    context 'ログインしている時' do
      it 'ホーム画面に、いざ決断！、皆の決断、の２種類のボタンがある' do
        login_as(user)
        visit root_path
        expect(page).to have_content 'いざ決断！'
        expect(page).to have_content '皆の決断' 
      end
    end
  end

  describe '選択肢画面のテスト' do
    before do 
      login_as(user)
      visit new_choice_path
    end
    context 'お題と選択肢を2つ入力して確認を押す' do
      it '最終確認画面に遷移し、お題と選択肢が正しく表示されている' do
        fill_in 'お題', with: 'テストお題'
        fill_in '一つ目の選択肢', with: 'テスト1' 
        fill_in '二つ目の選択肢', with: 'テスト2'
        click_on '確認する'
        expect(current_path).to eq(confirm_choices_path)
        expect(page).to have_content 'テストお題'
        expect(page).to have_content 'テスト1'
        expect(page).to have_content 'テスト2'
      end
    end

    context 'お題と選択肢を3つ以上入力して確認を押す' do
      it '最終確認画面に遷移し、お題と選択肢が正しく表示されている' do
        fill_in 'お題', with: 'テストお題'
        fill_in '一つ目の選択肢', with: 'テスト1' 
        fill_in '二つ目の選択肢', with: 'テスト2'
        find('.plus.icon').click
        fill_in '三つ目の選択肢', with: 'テスト3'
        click_on '確認する'
        expect(current_path).to eq(confirm_choices_path)
        expect(page).to have_content 'テストお題'
        expect(page).to have_content 'テスト1'
        expect(page).to have_content 'テスト2'
        expect(page).to have_content 'テスト3'
      end
    end

    context 'お題を空欄のまま確認を押す' do
      it '最終確認画面に遷移し、お題に「なし」と表示されている' do
        fill_in '一つ目の選択肢', with: 'テスト1' 
        fill_in '二つ目の選択肢', with: 'テスト2'
        click_on '確認する'
        expect(current_path).to eq(confirm_choices_path)
        expect(page).to have_content 'なし'
        expect(page).to have_content 'テスト1'
        expect(page).to have_content 'テスト2'        
      end
    end

    context 'お題を空欄、選択肢も空欄で確認を押す' do
      it '画面遷移せずに、エラーメッセージが表示される' do
        click_on '確認する' 
        expect(page).to have_content '一つ目の選択肢を入力してください'
        expect(page).to have_content '二つ目の選択肢を入力してください'
      end
    end

    context '確認画面を挟まず、直接決断結果画面に飛ぶ' do
      it '画面遷移せずに、エラーメッセージが表示される' do
        visit result_choice_path(1)
        expect(current_path).to eq(new_choice_path)
        expect(page).to have_content 'お題と選択肢を入力するのだ'
      end
    end
  end

  describe '確認画面のテスト' do
    before do
      login_as(user)
      create_two_choice
    end
    context 'いざ！を押す' do
      it '決断結果画面が正しく表示され、データベースに保存される' do
        click_on 'いざ！'
        expect(page).to have_content '今回の決断！'
        expect(page).to have_content('テスト1') | have_content('テスト2')
        expect(Choice.last.title).to eq 'テストお題'
      end
    end

    context '選択肢を考え直すを押す' do
      it '選択肢登録画面がレンダリングされ、フォームにはすでに値が入っている' do
        click_on '選択肢を考え直す'
        expect(page).to have_content 'お題と選択肢を入力せよ'
        expect(page).to have_content 'テストお題'
        expect(page).to have_content 'テスト1'
        expect(page).to have_content 'テスト2'
      end
    end
    
    context 'やっぱり自分で決断するを押す' do
      fit 'ホーム画面に遷移する' do
        click_on 'やっぱり自分で決断する' 
        expect(current_path).to eq(root_path)
      end
    end

    context '情けをかけるを押す' do
      fit '情けをかけるページに遷移し、各選択肢とラジオボタンが表示されている' do
        click_on '情けをかける'
        expect(current_path).to eq(compassion_choices_path)
        expect(page).to have_selector '.checkbox', text: 'テスト1'
        expect(page).to have_selector '.checkbox', text: 'テスト2'
      end
    end
  end
  describe '武士の情け画面のテスト' do
    before do
      login_as(user)
      create_two_choice
      click_on '情けをかける'
    end
    context 'いざ！を押す' do
      it '決断結果が正しく表示され、データベースに保存される' do
        expect(page).to have_content '今回の決断！'
        expect(page).to have_content('テスト1') | have_content('テスト2')
        expect(Choice.last.title).to eq 'テストお題'     
      end
    end
  end
end