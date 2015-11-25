class CreateUsers < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  		t.string :username
  		t.string :email
  		t.string :password_hash
      t.string :gender
      t.string :location
      t.timestamps null: false
  	end
  end
end
