class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
    if Product.exists?(:id => params[:id])
      @product = Product.find(params[:id])
    else
      flash[:danger] = "Product doesn't exist!"
      redirect_to products_url
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "Product added!"
      redirect_to @product
    else
      flash[:danger] = "Product create failed"
      render 'new'
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
      flash[:danger] = "Product update failed"
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
