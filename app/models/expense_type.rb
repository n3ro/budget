class ExpenseType < ActiveRecord::Base
  has_many :expense
end
