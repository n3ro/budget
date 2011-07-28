class Expense < ActiveRecord::Base
  belongs_to :expense_type
  belongs_to :account
  composed_of :amount, :class_name => "Money", :mapping => %w(amount amount)

  def self.total_expenses(id)
    expense = Expense.where :account_id => id
    expense.inject(0){|sum,item| sum + item.amount}
  end
end
