class CreateExpenses < ActiveRecord::Migration
  def self.up
    create_table :expenses do |t|
      t.integer :amount
      t.text :description
      t.references :account
      t.references :expense_type

      t.timestamps
    end
  end

  def self.down
    drop_table :expenses
  end
end
