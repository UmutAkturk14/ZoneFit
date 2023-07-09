class AddMoreMacrosToRecipe < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :trans_fat, :integer
    add_column :recipes, :cholesterol, :integer
    add_column :recipes, :sodium, :integer
    add_column :recipes, :dietary_fiber, :integer
  end
end
