class AddResultToChoices < ActiveRecord::Migration[6.0]
  def change
    add_column :choices, :result, :string
  end
end
