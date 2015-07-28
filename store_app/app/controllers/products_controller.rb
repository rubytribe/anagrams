class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params) #not final implem
    if @product.save
      flash[:success] = "Product added!"
      flash.keep
      redirect_to @product
    else render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      flash[:success] = "Product updated"
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    Product.find(params[:id]).destroy
    flash[:success] = "Product deleted"
    redirect_to products_url
  end

  private

    def product_params
      params.require(:product).permit(:title, :description, :image_url, :price)
    end

end
