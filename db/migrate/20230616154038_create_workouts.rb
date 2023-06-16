class CreateWorkouts < ActiveRecord::Migration[7.0]
  def change
    create_table :workouts do |t|
      t.string :title
      t.text :description
      t.string :url
      t.string :difficulty
      t.string :muscle_group
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
