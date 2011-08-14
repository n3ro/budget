
class Expense < ActiveRecord::Base
  belongs_to :expense_type
  belongs_to :account

  validates_presence_of :account_id, :expense_type_id, :amount
  validates_numericality_of :account_id, :expense_type_id, :amount

  # TODO: take advantage of this modifier... got problems =(
  #composed_of :amount, :class_name => "Money", :mapping => %w(amount value),  :converter => Proc.new { |balance| balance.to_money }
  #composed_of :amount, :mapping => %w(amount value)

  before_validation :before_expense

  def self.total(expenses)# expenses = Array of expenses objects
    expenses.inject(0){|sum,item| sum + item.amount}
  end

  def before_expense
    #TODO: all this validations in one line please lol
    if !self.account.nil?
      if self.account.can_spend? self.amount
        errors[:amount] << "out of balance" 
      end
    end
  end

end

