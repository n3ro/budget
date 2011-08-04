class CreateIncomes < ActiveRecord::Migration
  def self.up
    create_table :incomes do |t|

      t.integer :amount
      t.references :account

      t.timestamps
    end
  end

  def self.down
    drop_table :incomes
  end
end
