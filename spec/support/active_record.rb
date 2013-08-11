ActiveRecord::Migration.verbose = false

class TestMigration < ActiveRecord::Migration
  def self.up
    create_table :users, :force => true do |t|
      t.column :name, :string, null: false
      t.column :email, :string, null: false
    end
  end

  def self.down
    drop_table :users
  end
end

class User < ActiveRecord::Base
  validates_presence_of :name, :email
end
