class OrdersController < ApplicationController
  before_action :load_models, only: [:new, :create, :edit, :update]
  before_action :check_user, only: [:show, :edit, :update, :delivered, :canceled]


  def index
    @orders = current_user.orders
  end

  def show; end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user

    if @order.save
      flash[:notice] = 'Pedido registrado com sucesso.'
      return redirect_to @order
    end

    flash.now[:notice] = 'Não foi possível criar pedido.'
    render :new
  end

  def edit; end

  def update
    if @order.update(order_params)
      flash[:notice] = 'Pedido atualizado com sucesso!'
      return redirect_to order_path(@order)
    end

    flash.now[:notice] = 'Não foi possível atualizar o pedido.'
    render :edit
  end

  def search
    @query = params[:query]
    @orders = Order.where('code LIKE ?', "%#{@query}%")

    redirect_to @orders.first if @orders.count == 1
  end

  def delivered
    @order = Order.find(params[:id])
    @order.delivered!

    redirect_to order_path(@order)
  end

  def canceled
    @order = Order.find(params[:id])
    @order.canceled!

    redirect_to order_path(@order)
  end

  private

  def check_user
    @order = Order.find params[:id]

    if @order.user != current_user
      flash[:alert] = 'Acesso não permitido.'
      redirect_to root_path
    end
  end

  def order_params
    params.require(:order).permit(
      :warehouse_id, :supplier_id, :expected_delivery_date
    )
  end

  def load_models
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end
end
