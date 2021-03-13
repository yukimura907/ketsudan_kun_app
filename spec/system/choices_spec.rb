require 'rails_helper'

RSpec.describe 'Choices', type: :system do
  describe 'ホーム画面表示について' do
    let(:user){ create :user }
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
end