class ChangeColumnNotNull < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :crypted_password, :string, null: true
  end
end
