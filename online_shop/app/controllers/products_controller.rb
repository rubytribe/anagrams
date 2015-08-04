class ProductsController < ApplicationController
  def create
    @product = current_user.products.build(product_params)
    if @product.save
      redirect_to '/products'
    else
      render 'new'
    end
  end

  def new
    @product = Product.new
  end

  def index
    @products = Product.all
  end
  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    if @product.update_attributes(product_params)
      redirect_to '/products'
    else
      render 'new'
    end
  end

  def destroy
    Product.find(params[:id]).destroy
    redirect_to '/products'
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end
end
