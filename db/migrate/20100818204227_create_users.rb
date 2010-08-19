class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :encrypted_password
      t.string :confirmation_token
      t.string :remember_token
      t.boolean :admin
      t.string :salt

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
