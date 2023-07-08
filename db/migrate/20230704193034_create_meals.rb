class CreateMeals < ActiveRecord::Migration[7.0]
  def change
    create_table :meals do |t|
      t.references :user, null: false, foreign_key: true
      t.string :ingredients
      t.integer :total_calories
      t.integer :total_protein
      t.integer :total_carbs
      t.integer :total_fats

      t.timestamps
    end
  end
end
