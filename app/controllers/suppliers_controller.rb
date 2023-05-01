class SuppliersController < ApplicationController
  before_action :find_supplier, except: [:index, :new, :create]

  def index
    @suppliers = Supplier.all
  end

  def show; end

  def new
    @supplier = Supplier.new
  end

  def edit; end

  def create
    @supplier = Supplier.new(suppliers_params)
    
    if @supplier.save
      flash[:notice] = 'Fornecedor cadastrado com sucesso.'
      return redirect_to @supplier
    end
    
    flash[:notice] = 'Não foi possível cadastrar fornecedor.'
    render 'new'
  end

  def update
    if @supplier.update(suppliers_params)
      flash[:notice] = 'Cadastrado atualizado com sucesso.'
      return redirect_to @supplier
    end
  
    flash[:notice] = 'Não foi possível atualizar fornecedor.'
    render 'edit'
  end

  private

  def suppliers_params
    params.require(:supplier).permit(
      :corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :email
    )
  end

  def find_supplier
    @supplier = Supplier.find(params[:id])
  end
end
