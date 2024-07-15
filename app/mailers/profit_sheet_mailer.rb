class ProfitSheetMailer < ApplicationMailer
  default from: ENV['SMTP_USERNAME']

  def send_profit_sheet(calculate_profit)
    @calculate_profit = calculate_profit
    attachments["profit_sheet_#{calculate_profit.id}.pdf"] = File.read(Rails.root.join("public", "profit_sheet_#{calculate_profit.id}.pdf"))
    mail(to: @calculate_profit.email, subject: 'Your Profit Sheet')
  end
end
