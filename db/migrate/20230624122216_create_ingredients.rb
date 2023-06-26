class CreateIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.float :protein
      t.float :carbohydrates
      t.float :fat
      t.float :calories
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
