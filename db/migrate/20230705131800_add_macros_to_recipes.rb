class AddMacrosToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :calories, :integer
    add_column :recipes, :fat, :integer
    add_column :recipes, :carbs, :integer
    add_column :recipes, :protein, :integer
    add_column :recipes, :saturated_fat, :integer
    add_column :recipes, :sugars, :integer
  end
end
