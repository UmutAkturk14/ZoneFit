class CreatePrivateChatrooms < ActiveRecord::Migration[7.0]
  def change
    create_table :private_chatrooms do |t|
      t.references :creator, foreign_key: { to_table: :users }
      t.references :joiner, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
