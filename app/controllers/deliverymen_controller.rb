class DeliverymenController < ApplicationController
  before_action :set_deliveryman, only: [:show, :update, :destroy]

  # GET /deliverymen
  def index
    @deliverymen = Deliveryman.order(name: :asc)

    render json: @deliverymen
  end

  # GET /deliverymen/1
  def show
    render json: @deliveryman
  end

  # POST /deliverymen
  def create
    @deliveryman = Deliveryman.new(deliveryman_params)

    if @deliveryman.save
      render json: @deliveryman, status: :created, location: @deliveryman
    else
      render json: @deliveryman.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /deliverymen/1
  def update
    if @deliveryman.update(deliveryman_params)
      render json: @deliveryman
    else
      render json: @deliveryman.errors, status: :unprocessable_entity
    end
  end

  # DELETE /deliverymen/1
  def destroy
    @deliveryman.destroy
  end

  def sales
    sales = Sale
      .where(deliveryman_id: params[:deliveryman_id])
      .paginate(params[:page], params[:per_page])
      .by_day(params[:day])

    render json: {
      sales: sales,
      info: {
        sales_count_total: sales.size,
        sales_amount_total: sales.sum(:delivery_fee),
        sales_count: sales.where(paid: false).size,
        sales_amount: sales.where(paid: false).sum(:delivery_fee)
      }
    }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deliveryman
      @deliveryman = Deliveryman.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def deliveryman_params
      params.require(:deliveryman).permit(:name, :avatar)
    end
end
