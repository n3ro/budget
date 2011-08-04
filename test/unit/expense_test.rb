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
  end

end
