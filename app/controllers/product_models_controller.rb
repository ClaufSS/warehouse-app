class ProductModelsController < ApplicationController
  before_action :find_product_model, only: [:show]
  before_action :set_product_model, only: [:create]
  before_action :authenticate_user!, only: [:index]


  def index
    @product_models = ProductModel.all
  end

  def show; end

  def new
    @product_model = ProductModel.new
    @suppliers = Supplier.all
  end

  def create
    if @product_model.save
      return redirect_to @product_model
    end

    @suppliers = Supplier.all
    flash.now[:notice] = 'Não foi possível criar modelo de produto'
    render :new
  end

  private

  def find_product_model
    @product_model = ProductModel.find(params[:id])
  end

  def set_product_model
    params_product_model = params.require(:product_model).permit(
      :name, :weight, :width, :height, :depth, :sku, :supplier_id
    )

    @product_model = ProductModel.new params_product_model
  end
end
