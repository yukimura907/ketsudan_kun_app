require 'rails_helper'

RSpec.describe Choice, type: :model do
  let(:choice){ build :choice, :without_title_and_result }
  it 'option_1, option_2が登録されている場合、有効である' do
    expect(choice).to be_valid
  end
  it 'titleが空の場合でも、有効である' do
    choice.title = nil
    expect(choice).to be_valid
  end
  it 'option_1が空の場合、無効である' do
    choice.option_1 = nil
    expect(choice).to be_invalid
  end
  it 'option_2が空の場合、無効である' do
    choice.option_2 = nil
    expect(choice).to be_invalid
  end

  it 'タイトルが16文字以上の場合、無効である' do
    choice.title = 'a' * 16
    expect(choice).to be_invalid
  end

  it '選択肢が16文字以上の場合、無効である' do
    choice.option_1 = 'a' * 16
    expect(choice).to be_invalid
  end
end
