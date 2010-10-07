class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.string :filepath
      t.string :filename
      t.string :content_type
      t.integer :width
      t.integer :height
      t.integer :size
      t.references :entry
      t.references :site

      t.timestamps
    end
    
    add_index :attachments, [:entry_id]
    add_index :attachments, [:site_id]
  end

  def self.down
    drop_table :attachments
  end
end
