class CreateItems < ActiveRecord::Migration
  def self.up
    execute 'CREATE TABLE items (id uuid PRIMARY KEY DEFAULT uuid_generate_v4());'
    change_table :items do |t|
      t.string  :name,        null: false
      t.string  :poster_image_url

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
