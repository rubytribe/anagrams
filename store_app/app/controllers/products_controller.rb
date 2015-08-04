class ProductsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :edit]
  before_action :correct_user, only: [:destroy, :edit]

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
    @product = current_user.products.build(product_params)
    if @product.save
      flash[:success] = "Product added!"
      redirect_to @product
    else
      @feed_items = []
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
    redirect_to request.referrer || products_url
  end

  private

    def product_params
      params.require(:product).permit(:title, :description, :image_url, :price)
    end

    def correct_user
      @product = current_user.products.find_by(id: params[:id])
      redirect_to root_url if @product.nil?
    end

end
