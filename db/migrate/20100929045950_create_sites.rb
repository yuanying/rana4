class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string :title
      t.text :description, :limit => 1024
      t.string :url
      t.string :path
      t.string :timezone

      t.timestamps
    end
  end

  def self.down
    drop_table :sites
  end
end
