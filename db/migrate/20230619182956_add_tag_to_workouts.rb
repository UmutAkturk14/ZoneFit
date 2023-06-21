class AddTagToWorkouts < ActiveRecord::Migration[7.0]
  def change
    add_column :workouts, :tag, :text
  end
end
