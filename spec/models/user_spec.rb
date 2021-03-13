require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user){ build(:user) }
  it '名前がある場合、有効である' do
    expect(user).to be_valid
  end

  it '名前がない場合、無効である' do
    user.name = nil
    expect(user).to be_invalid
  end

  it '名前が重複している場合、無効である' do
    user.save
    another_user = User.new(
      name: 'test_user'
    )
    expect(another_user).to be_invalid
  end

  it '名前が16文字以上の場合、無効である' do
    user.name = 'a' * 16
    expect(user).to be_invalid
  end
end
