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
      flash[:notice] = "Supplier successfully created"
      redirect_to @supplier
    end
    
    flash[:notice] = "Something went wrong"
    render 'new'
  end

  def update
    if @supplier.update(suppliers_params)
      flash[:notice] = "Supplier was successfully updated"
      return redirect_to @supplier
    end
  
    flash[:notice] = "Something went wrong"
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

