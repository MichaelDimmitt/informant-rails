if defined?(ActiveRecord)
  ActiveRecord::Migration.verbose = false

  migration_base_class = ActiveRecord::Migration.respond_to?(:[]) ?
    ActiveRecord::Migration[4.2] : ActiveRecord::Migration

  class TestMigration < migration_base_class
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
    validates_presence_of :email
    validates_length_of :name, minimum: 2
  end
end
