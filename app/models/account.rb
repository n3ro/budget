class Account < ActiveRecord::Base
  belongs_to  :owner
  belongs_to :account_type
  has_many :expense
  composed_of :balance, :class_name => "Money", :mapping => %w(balance amount)
end
