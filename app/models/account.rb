class Account < ActiveRecord::Base
  belongs_to :owner
  belongs_to :account_type
  has_many :expense
  has_many :income
  # TODO: try taking advantage of this modifier... got problems =(
  #composed_of :balance, :class_name => "Money", :mapping => %w(balance value)


  def self.debit(account_id, amnt)
    # can_expense is verified before savin the expense
    account = Account.find account_id
    account.balance -= amnt
    account.save
  end

  def can_spend?(amnt)
    self.balance < amnt
  end

end
