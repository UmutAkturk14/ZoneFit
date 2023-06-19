class AddColumnsToWorkouts < ActiveRecord::Migration[7.0]
  def change
    add_column :workouts, :style, :string
    add_column :workouts, :equipment, :string
  end
end
