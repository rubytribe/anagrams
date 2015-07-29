class ProductsController < ApplicationController
  def create
    @product = Product.new(product_params)
    @product.save
    redirect_to '/products/show'
  end

  def new
    @product = Product.new
  end

  def show
    @products = Product.all
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    redirect_to '/products/show'
  end

  def destroy
    Product.find(params[:id]).destroy
    redirect_to '/products/show'
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end
end
