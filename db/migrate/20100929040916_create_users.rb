class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :cas_id
      t.string :name
      t.string :email
      t.text :description, :limit => 1024

      t.timestamps
    end
    
    add_index :users, :cas_id
  end

  def self.down
    drop_table :users
  end
end
