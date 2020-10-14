class StatisticsController < ApplicationController
  # GET /statistic
  def index
    sales = Sale.by_month(params[:date])
    expenses = Expense.by_month(params[:date])

    cash = sales.where(payment_method: :cash).sum(:value)
    credit_card = sales.where(payment_method: :credit_card).sum(:value)
    sale_total = cash + credit_card
    sales_json = {
      cash: cash,
      credit_card: credit_card,
      sale_total: sale_total
    }

    render json: {
      sales: sales_json,
      expenses: {
        deliveries_fee: sales.sum(:delivery_fee),
        acai: expenses.where(kind: :acai).sum(:value),
        complement: expenses.where(kind: :complement).sum(:value),
        others: expenses.where(kind: :others).sum(:value),
        deliveryman: expenses.where(kind: :deliveryman).sum(:value),
        employees: expenses.where(kind: :employees).sum(:value)
      }
    }
  end
end
