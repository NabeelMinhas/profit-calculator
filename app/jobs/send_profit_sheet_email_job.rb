class SendProfitSheetEmailJob < ApplicationJob
  queue_as :default

  def perform(calculate_profit_id)
    calculate_profit = CalculateProfit.find(calculate_profit_id)
    ProfitSheetMailer.send_profit_sheet(calculate_profit).deliver_now
  end
end
