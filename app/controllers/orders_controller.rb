class OrdersController < ApplicationController
  def show
    @order = Order.find params[:id]
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
end
