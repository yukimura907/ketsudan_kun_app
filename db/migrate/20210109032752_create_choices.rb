class CreateChoices < ActiveRecord::Migration[6.0]
  def change
    create_table :choices do |t|
      t.string :title, null: false
      t.string :option_1, null: false
      t.string :option_2, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
