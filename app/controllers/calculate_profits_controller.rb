class CalculateProfitsController < ApplicationController
  def new
    @calculate_profit = CalculateProfit.new
  end

  def create
    @calculate_profit = CalculateProfit.new(calculate_profit_params)
    if @calculate_profit.save
      ProfitSheet.new(@calculate_profit).generate_pdf
      redirect_to @calculate_profit, notice: 'Calculation was successfully created.'
    else
      render :new
    end
  end

  def show
    @calculate_profit = CalculateProfit.find(params[:id])
  end

  private

  def calculate_profit_params
    params.require(:calculate_profit).permit(:address, :loan_term, :purchase_price, :repair_budget, :arv, :name, :email, :phone)
  end
end
