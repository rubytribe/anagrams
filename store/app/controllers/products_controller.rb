class ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def show
    if Product.exists?(id: params[:id])
      @product = Product.find(params[:id])
    else
      flash[:notice] = "The product with the ID #{params[:id]} doesn't exist"
      redirect_to products_url
    end
  end

  def index
    @products = Product.all
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "Product successfully created"
      redirect_to @product
    else
      flash.now[:danger] = "Product creation failed"
      render 'new'
    end
  end

  def edit
    if Product.exists?(id: params[:id])
      @product = Product.find(params[:id])
    else
      flash[:notice] = "The product with the ID #{params[:id]} doesn't exist"
      redirect_to products_url
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      flash[:succes] = "Product updated"
      redirect_to @product
    else
      flash.now[:danger] = "Product edit failed"
      render 'edit'
    end
  end

  def destroy
    Product.find(params[:id]).destroy
    flash[:success] = "Product successfully deleted"
    redirect_to products_url
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :image_url, :price)
  end
end
