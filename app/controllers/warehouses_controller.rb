class WarehousesController < ApplicationController
  before_action :set_warehouse, only: [:show, :edit, :update, :destroy]

  def index
    @warehouses = Warehouse.all
  end

  def show; end

  def new
    @warehouse = Warehouse.new
  end
  
  def create
    @warehouse = Warehouse.new(warehouse_params)

    if @warehouse.save
      return redirect_to root_path, notice: 'Galpão cadastrado com sucesso'
    end

    flash.now[:notice] = 'Galpão não cadastrado'
    render :new
  end

  def edit; end

  def update
    if @warehouse.update(warehouse_params)
      flash[:notice] = 'Galpão atualizado com sucesso.'
      return redirect_to @warehouse
    end

    flash.now[:notice] = 'Não foi possível atualizar o galpão.'
    render :edit
  end

  def destroy
    @warehouse.destroy
    flash[:notice] = 'Galpão removido com sucesso.'
    redirect_to root_path
  end

  private

  def set_warehouse
    @warehouse = Warehouse.find params[:id]
  end

  def warehouse_params
    params.require(:warehouse).permit(
      :name, :code, :city, :address, :cep, :area, :description
    )
  end
  
  
end
