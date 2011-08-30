class CreateRecords < ActiveRecord::Migration
  def self.up
    create_table :records do |t|
      t.references :account
      t.boolean :debit
      t.integer :trans_id
      t.integer :before
      t.integer :amount
      t.integer :after

      t.timestamps
    end
  end

  def self.down
    drop_table :records
  end
end
