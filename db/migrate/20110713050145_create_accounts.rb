class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|

      t.references :owner
      t.references :account_type
      t.integer :balance

      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
