
class Admin::ProductsController < ApplicationController

  before_action :authenticate_admin!

  def index
     @products = Product.page(params[:page]).per(10).order(:id)
  end

  def new
    @product = Product.new
    @genres = Genre.all

  end

  def create
    @product = Product.new(product_params)
    @product.save

    redirect_to admin_products_path

  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
    @genres = Genre.all
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    redirect_to admin_product_path(@product.id)
  end

  private

  def product_params

    params.require(:product).permit(:image, :product_name, :introduction, :price, :is_sale, :genre_id )

  end

end