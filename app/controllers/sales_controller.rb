class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :update, :destroy]

  # GET /sales
  def index
    @sales = Sale.by_day(params[:day])

    unless params[:payment_method].blank?
      @sales = @sales.by_payment_method(params[:payment_method])
    end

    sales = @sales
      .includes(:deliveryman)
      .paginate(params[:page], params[:per_page])

    sub_total = @sales.sum(:value)
    total = sub_total - @sales.sum(:delivery_fee)

    render json: {
      sales: sales.as_json(include: :deliveryman),
      info: {
        credit: total,
        sub_total: sub_total,
        quantity: @sales.size
      }
    }
  end

  # GET /sales/1
  def show
    render json: @sale.as_json(include: :deliveryman)
  end

  # POST /sales
  def create
    @sale = Sale.new(sale_params)

    if @sale.save
      render json: @sale, status: :created, location: @sale
    else
      render json: @sale.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sales/1
  def update
    if @sale.update(sale_params)
      render json: @sale
    else
      render json: @sale.errors, status: :unprocessable_entity
    end
  end

  def bunch_update
    sales = Sale.where(id: params[:ids]).update(paid: true)

    render json: sales
  end

  # DELETE /sales/1
  def destroy
    @sale.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sale_params
      params
        .require(:sale)
        .permit(:value, :charge, :payment_method, :deliveryman_id,
                :delivery_method, :delivery_fee, :paid, :receiver, :created_at)
    end
end
