class ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def show
    @product = Product.find(params[:id])
  end

  def index
    @products = Product.all
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product
    else
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      flash[:succes] = "Product updated"
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :image_url, :price)
  end
end
