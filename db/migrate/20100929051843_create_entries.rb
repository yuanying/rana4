class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.string :title
      t.string :path
      t.string :identify_string,    :limit => 256
      t.boolean :is_public
      t.string :format_type
      t.text :description,          :limit => 1024
      t.text :body_text,            :limit => 10000
      t.text :extend_text,          :limit => 10000
      t.text :formated_body_text
      t.text :formated_extend_text
      t.integer :site_id
      t.integer :user_id
      t.datetime :posted_at

      t.timestamps
    end
    
    add_index :entries, ["identify_string"], :name => "entries_indentify_string_index"
    add_index :entries, ["site_id"], :name => "entries_site_id_index"
    add_index :entries, ["user_id"], :name => "entries_user_id_index"
    add_index :entries, ["posted_at"], :name => "entries_posted_at_index"
  end

  def self.down
    drop_table :entries
  end
end
