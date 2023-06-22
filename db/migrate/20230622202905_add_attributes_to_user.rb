class AddAttributesToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :nickname, :string
    add_column :users, :date_of_birth, :datetime
    add_column :users, :public, :boolean, default: false
    add_column :users, :location, :string
    add_column :users, :lat, :float
    add_column :users, :lng, :float
  end
end
