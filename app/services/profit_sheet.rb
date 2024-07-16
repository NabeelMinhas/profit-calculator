require 'prawn'
include ActionView::Helpers::NumberHelper

class ProfitSheet
  LOGO_IMG_PATH = 'app/assets/images/logo.png'

  def initialize(calculate_profit)
    @calculate_profit = calculate_profit
    @pdf = Prawn::Document.new
    @document_width = @pdf.bounds.width
  end

  def generate_pdf
    header
    profit_sheet
    client_info
    report
    @pdf.render_file Rails.root.join("public", "profit_sheet_#{@calculate_profit.id}.pdf")
  end

  def header
    @pdf.repeat :all do
      @pdf.canvas do
        @pdf.move_cursor_to(@pdf.bounds.top - 30)
  
        # Define the table with logo and text
        table_data = [
          [
            { image: "#{Rails.root}/app/assets/images/logo.png", fit: [150, 50], position: :center, vposition: :center },
            { content: "Estimate your project's profit potential", align: :right, valign: :center, text_color: '808080' }
          ]
        ]
  
        # Draw the table
        @pdf.table(table_data, cell_style: { border_width: 0, padding: [0, 10], size: 12 })
  
        # Add a margin before the horizontal rule
        @pdf.move_down 20
        @pdf.stroke_horizontal_rule
        @pdf.move_down 20
      end
    end
  end
  

  def profit_sheet
    status_results = [[@calculate_profit.loan_term, number_to_currency(@calculate_profit.purchase_price), number_to_currency(@calculate_profit.repair_budget), number_to_currency(@calculate_profit.arv)], %w[Loan Purchase Repair ARV]]
    text_colors = { 1 => 'C8102F', 2 => '83BC41', 3 => 'FDB357', 4 => 'BBBBBB' }

    profit_sheet_table = @pdf.make_table(status_results) do |table|
      table.row(0).font_style = :bold

      profit_sheet_status_rows = [0, 1]
      profit_sheet_status_rows.each do |row_index|
        text_colors.each do |column_index, color|
          table.row(row_index).column(column_index).style(text_color: color)
        end
      end

      table.row(0..1).border_width = 0
      table.row(0..1).column(0).border_color = 'c0c5ce'
      table.row(0..1).column(0).borders = [:right]
      table.row(0).size = 17
      table.row(1).size = 11
    end

    profit_sheet_column_widths = [@document_width * 2 / 3, @document_width * 1 / 3]
    profit_sheet_title_data = [['Profit Sheet']]
    profit_sheet_title_options = {
      column_widths: [@document_width],
      row_colors: ['EDEFF5'],
      cell_style: {
        border_width: 0,
        padding: [15, 12, 1, 20],
        size: 20,
        # font: 'montserrat',
        font_style: :normal
      }
    }

    profit_sheet_logo_data = [[profit_sheet_table]]
    profit_sheet_logo_options = {
      column_widths: @document_width,
      row_colors: ['EDEFF5'],
      cell_style: {
        border_width: 2,
        padding: [15, 15],
        borders: [:bottom],
        border_color: 'c9ced5'
      }
    }

    @pdf.table(profit_sheet_title_data, profit_sheet_title_options)
    @pdf.table(profit_sheet_logo_data, profit_sheet_logo_options)

    @pdf.move_down 20
  end

  def client_info
    client_info_data = [['Client Information', '', ''], ['Name:', 'Phone Number:', 'Email:'],
              [@calculate_profit.name, @calculate_profit.phone, @calculate_profit.email]]
   
    client_info_options = {
     width: @document_width,
     row_colors: ['ffffff'],
     cell_style: {
      border_width: 0,
      borders: [:bottom],
      border_color: 'c9ced5',
      padding: [10, 10]
     }
    }
   
    @pdf.table(client_info_data, client_info_options) do |table|
     table.row(0).border_width = 0.5
     table.row(1).text_color = '888892'
     table.row(0).padding = [10, 15]
     table.row(2).size = 11
    end
    @pdf.move_down 20
  end

  def report
    report_data = [['Report', '', 'View detailed list in new report'],
           ['Loan Amount', 'Interest Expense', 'Estimated Profit'],
           [@calculate_profit.loan_amount, @calculate_profit.total_interest_expense, @calculate_profit.estimated_profit]]
   
    report_data_options = {
     width: @document_width,
     row_colors: ['ffffff'],
     cell_style: {
      border_width: 1,
      borders: [:bottom],
      border_color: 'c9ced5'
     }
    }
   
    @pdf.table(report_data, report_data_options) do |table|
     test_status = table.rows(1..-1).column(-1)
   
     table.row(0..1).border_width = 0.5
     table.row(0).column(2).text_color = '2787c4'
     table.row(0).column(2).size = 11
     table.row(1).background_color = 'EDEFF5'
     table.row(1..-1).column(1..2).align = :center
     table.row(1).text_color = '465579'
     table.row(1).size = 10
     table.row(1..-1).padding = [10, 15]
     table.row(0).padding = [7, 15]
     table.row(2).column(2).style do |cell|
      cell.text_color = cell.content.to_f >= 0 ? '83BC41' : 'C8102F'
     end
    end
  end
end
