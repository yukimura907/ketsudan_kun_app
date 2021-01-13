class AddChoiceColumnToChoices < ActiveRecord::Migration[6.0]
  def change
    add_column :choices, :option_3, :string
    add_column :choices, :option_4, :string
    add_column :choices, :option_5, :string
  end
end
