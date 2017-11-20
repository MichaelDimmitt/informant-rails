if CAPABILITIES[:active_record]
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

    validate :base_error

    attr_accessor :add_base_error

    def base_error
      errors[:base] << 'This is a base error' if add_base_error
    end
  end
end
