class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :encrypted_password
      t.string :confirmation_token
      t.string :remember_token
      t.string :salt
      t.string :state
      t.boolean :enrolled, :default => false
      t.boolean :admin, :default => false
      t.boolean :scrum, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
