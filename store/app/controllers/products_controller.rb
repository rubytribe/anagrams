class ProductsController < ApplicationController
  before_action :logged_in_user, only: [ :create, :destroy, :edit, :new]
  before_action :correct_user, only: [:destroy, :edit]
  #before_action :admin_user, only: [:destroy, :edit]

  def new
    #@product = Product.new
    @product = current_user.products.build if logged_in?
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
    @products = Product.paginate(page: params[:page], :per_page => 10)
  end

  def create
    @product = current_user.products.build(product_params)
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
      flash[:success] = "Product updated"
      redirect_to @product
    else
      flash.now[:danger] = "Product edit failed"
      render 'edit'
    end
  end

  def destroy
    Product.find(params[:id]).destroy
    flash[:success] = "Product successfully deleted"
    redirect_to request.referrer || products_url
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :image_url, :price)
  end

  def correct_user
     @product = current_user.products.find_by(id: params[:id])
     if !current_user.admin? && @product.nil?
       redirect_to products_url
       flash[:danger] = "You are not allowed to do that."
     end
   end

end
