require 'rails_helper'

RSpec.describe 'Choices', type: :system do
  let(:first_user){ create :user, name: 'true_user', email: 'sample@example.com' }
  let(:second_user){ create :user, name: 'fake_user', email: 'sample2@example.com' }
  let(:today_choice){ create :choice, :today }
  let(:yesterday_choice){ create :choice, :yesterday, title: '昨日のお題' }

  describe 'ユーザー詳細画面のテスト' do
    before do
      login_as(first_user)
    end
    context '自分のプロフィール画面を開く' do
      xit '本日の決断回数が正しく表示されている' do
        visit user_path(first_user)
        expect(page).to have_content "#{first_user.name}は、今日は合計1回も決断を他人に委ねてしまった"
      end

      xit 'これまでの決断回数が正しく表示されている' do
        visit user_path(first_user)
        expect(page).to have_content "#{first_user.name}は、今までに合計2回も決断を他人に委ねてしまった"
      end

      it 'その日の決断回数に応じた正しい優柔不断度が表示されている' do
      end
      
      it '下された決断が、正しく表示されている' do
        
      end

      it '退会ボタンが表示されている' do
        
      end
    end

    context '他人のプロフィール画面を開く' do
      it '退会画面が表示されていない' do
        
      end
    end
  end
end