class CalculateProfit < ApplicationRecord
  validates :address, :loan_term, :purchase_price, :repair_budget, :arv, :name, :email, :phone, presence: true

  def max_loan_amount_by_purchase_price
    purchase_price * 0.9
  end

  def max_loan_amount_by_arv
    arv * 0.7
  end

  def loan_amount
    [max_loan_amount_by_purchase_price, max_loan_amount_by_arv].min
  end

  def monthly_interest_rate
    0.13 / 12
  end

  def total_interest_expense
    loan_amount * (1 + monthly_interest_rate)**loan_term - loan_amount
  end

  def estimated_profit
    arv - loan_amount - total_interest_expense
  end
end
