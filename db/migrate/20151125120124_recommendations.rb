class Recommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.integer :user_id
      t.integer :movie_id
      t.boolean :recommended
      t.timestamps null: false
    end
  end
end
