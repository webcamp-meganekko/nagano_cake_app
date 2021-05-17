class Public::ProductsController < ApplicationController

  def index
    @products = Product.page(params[:page]).per(8).order(:id)
    @product_count = Product.count
  end

  def show
    @product = Product.find(params[:id])
    @cart = Cart.new
  end

  def search
    @products = Product.page(params[:page]).per(8).order(:id)
    @genre = Genre.find(params[:genre_id])
    @products_genre = Product.where(genre_id: @genre)
    @genre_name = @genre.genre_name
    
  end

  def product_params

    params.require(:product).permit(:image, :product_name, :introduction, :price, :is_sale, :genre_id )

  end

end
