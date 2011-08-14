class Money
  include ActionView::Helpers::NumberHelper
  include Comparable

  attr_reader :value

  EXCHANGE_RATES = { 
    "ARS_TO_VEF" => 1.03893,
    "ARS_TO_USD" => 1.03893 
  }

  def initialize(value)
    @amount = value
    @currency = "ARS"
  end

  def to_currency
    number_to_currency(@amount)
  end

  def to_s
    @amount.to_s
  end

  def to_i
    @amount.to_i
  end

  def exchange_to(other_currency)
    exchanged_amount = (amount * EXCHANGE_RATES["#{currency}_TO_#{other_currency}"]).floor
    Money.new(exchanged_amount, other_currency)
  end

  def ==(other_money)
    amount == other_money.amount && currency == other_money.currency
  end

  def <=>(other_money)
    if currency == other_money.currency
      amount <=> amount
    else
      amount <=> other_money.exchange_to(currency).amount
    end
  end

end
