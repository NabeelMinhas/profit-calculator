require 'prawn'
include ActionView::Helpers::NumberHelper

class ProfitSheet
  def initialize(calculate_profit)
    @calculate_profit = calculate_profit
  end

  def generate_pdf
    Prawn::Document.new do |pdf|
      pdf.text "Longleaf Lending Profit Sheet", size: 30, style: :bold, align: :center
      pdf.move_down 20

      pdf.text "Address: #{@calculate_profit.address}"
      pdf.text "Loan Term: #{@calculate_profit.loan_term} months"
      pdf.text "Purchase Price: #{number_to_currency(@calculate_profit.purchase_price)}"
      pdf.text "Repair Budget: #{number_to_currency(@calculate_profit.repair_budget)}"
      pdf.text "After Repair Value (ARV): #{number_to_currency(@calculate_profit.arv)}"
      pdf.text "Name: #{@calculate_profit.name}"
      pdf.text "Email: #{@calculate_profit.email}"
      pdf.text "Phone: #{@calculate_profit.phone}"
      pdf.move_down 20

      pdf.text "Calculated Values", size: 20, style: :bold
      pdf.text "Loan Amount: #{number_to_currency(@calculate_profit.loan_amount)}"
      pdf.text "Interest Expense: #{number_to_currency(@calculate_profit.total_interest_expense)}"
      pdf.text "Estimated Profit: #{number_to_currency(@calculate_profit.estimated_profit)}"

      pdf.render_file Rails.root.join("public", "profit_sheet_#{@calculate_profit.id}.pdf")
    end
  end
end
