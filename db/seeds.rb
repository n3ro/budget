
AccountType.create :id => 1, :name => "Debit", :description => "A debit account"
AccountType.create :id => 2, :name => "Save", :description => "A saving account"

ExpenseType.create :id => 1, :name => "Food", :description => "Restaurants, locals, etc.."
ExpenseType.create :id => 2, :name => "Transport", :description => "Subte, Bus, Taxi"
ExpenseType.create :id => 2, :name => "Laundry", :description => "Sonia"

Owner.create :id => 1, :name => "Name One", :age => 24
Owner.create :id => 2, :name => "Name Two", :age => 42

Account.create :id => 1, :owner_id => 1, :account_type_id => 1, :balance => 2000
Account.create :id => 2, :owner_id => 2, :account_type_id => 2, :balance => 2000

Expense.create :id => 1, :amount => 1200, :account_id => 1, :description => "shitty", :expense_type_id => 1
Expense.create :id => 2, :amount => 200, :account_id => 1, :description => "shitty again", :expense_type_id => 2

Income.create :id => 1, :amount => 1200, :description => "shitty", :account_id => 1
Income.create :id => 1, :amount => 1200, :description => "shitty 2", :account_id => 1

Record.create :id => 1, :account_id => 1, :debit => true, :trans_id => 1, :before => 2000, :amount => 1200, :after => 800 
