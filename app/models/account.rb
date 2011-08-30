class Account < ActiveRecord::Base
  belongs_to :owner
  belongs_to :account_type
  has_many :expense
  has_many :income
  # TODO: try taking advantage of this modifier... got problems =(
  #composed_of :balance, :class_name => "Money", :mapping => %w(balance value)


  def self.debit(expense)
    # can_expense is verified before savin the expense
    record = Record.new
    account = Account.find expense.account_id

    record.account_id = expense.account_id
    record.debit = true
    record.before = account.balance
    account.balance -= expense.amount
    record.after = account.balance
    record.amount = expense.amount
    if account.save #FIXME: ... self explained
      record.trans_id = expense.id
      record.save
    end
  end

  def self.credit(income)
    # can_expense is verified before savin the expense
    record = Record.new
    account = Account.find income.account_id

    record.account_id = income.account_id
    record.debit = false
    record.before = account.balance
    account.balance += income.amount
    record.after = account.balance
    record.amount = income.amount
    if account.save #FIXME: ... self explained
      record.trans_id = income.id
      record.save
    end
  end

  def can_spend?(amnt)
    self.balance < amnt
  end

end
