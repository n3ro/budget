class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.references :account
      t.integer :transaction
      t.decimal :before_balance
      t.decimal :after_balance

      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
