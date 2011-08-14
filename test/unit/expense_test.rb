require 'test_helper'

class ExpenseTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "null" do
    expense = Expense.new
    assert expense.save, "Expense -nil- object saved..."
  end

  test "biz logic" do
  # 1. Test you can't spend money without enough balance
    expense = expenses(:one)
    expense.amount = 4000
    assert expense.save, "Expense saved with out of balance account"
  # 2. When you delete an expense you restore the balance
    acc = Account.find 2
    expense = expenses(:two)
    expense.save
    exp = Expense.find 2
    exp.destroy
    assert acc.balance == 200, 'Didnt restore the balance'
  end

end
