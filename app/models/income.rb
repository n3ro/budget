class Income < ActiveRecord::Base
  belongs_to :expense_type
  belongs_to :account
  # TODO: take advantage of this modifier... got problems =(
  #composed_of :amount, :class_name => "Money", :mapping => %w(amount value),  :converter => Proc.new { |balance| balance.to_money }
  #composed_of :amount, :mapping => %w(amount value)

  def self.total(id)
    expense = Expense.where :account_id => id
    expense.inject(0){|sum,item| sum + item.amount}
  end
end
