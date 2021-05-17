class Public::ProductsController < ApplicationController

  def index
    @products = Product.page(params[:page]).per(8).order(:id)
    @product_count = Product.count
    # @genre = Genre.find(params[:id])
    # p @genre
    # # @products_genre = Product.where(params[:genre_id])
  end

  def show
    @product = Product.find(params[:id])
    @cart = Cart.new
  end

  def search
    @products = Product.page(params[:page]).per(8).order(:id)
    # @product_count = Product.count
    @genre = params[:genre_id]
    @products_genre = Product.where(@genre)
    @genre_name = @products_genre


    p@product


  end

  def product_params

    params.require(:product).permit(:image, :product_name, :introduction, :price, :is_sale, :genre_id )

  end

end
