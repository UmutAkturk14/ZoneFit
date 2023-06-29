class AddDescriptionToChatrooms < ActiveRecord::Migration[7.0]
  def change
    add_column :chatrooms, :description, :string
  end
end
