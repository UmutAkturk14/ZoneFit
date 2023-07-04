class CreatePrivateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :private_messages do |t|
      t.string :content
      t.references :private_chatroom, null: false, foreign_key: true
      t.references :sender, null: false, foreign_key: { to_table: "users" }
      t.references :recipient, null: false, foreign_key: { to_table: "users" }

      t.timestamps
    end
  end
end
