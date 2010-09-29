class CreateWritings < ActiveRecord::Migration
  def self.up
    create_table :writings do |t|
      t.integer :site_id
      t.integer :user_id
      t.boolean :is_owner
      t.string :default_format_type, :default => 'hatenaFormat'

      t.timestamps
    end
    
    add_index :writings,  ['site_id'],  :name => 'writings_site_id_index'
    add_index :writings,  ['user_id'],  :name => 'writings_user_id_index'
  end

  def self.down
    drop_table :writings
  end
end
