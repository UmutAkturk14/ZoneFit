class AddThumbnailToWorkouts < ActiveRecord::Migration[7.0]
  def change
    add_column :workouts, :thumbnail, :string
  end
end
