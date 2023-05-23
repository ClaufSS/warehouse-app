class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find params[:id]

    if @order.user != current_user
      flash[:alert] = 'Você não possui autorização de acesso ao pedido.'
      redirect_to root_path
    end
  end

  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create
    order_params = params.require(:order).permit(
      :warehouse_id, :supplier_id, :expected_delivery_date
    )

    @order = Order.new order_params
    @order.user = current_user

    if @order.save
      flash[:notice] = 'Pedido registrado com sucesso.'
      return redirect_to @order
    end

    flash.now[:notice] = 'Não foi possível criar pedido.'
    render :new
  end

  def edit
  end

  def search
    @query = params[:query]
    @orders = Order.where('code LIKE ?', "%#{@query}%")

    redirect_to @orders.first if @orders.count == 1
  end
end
