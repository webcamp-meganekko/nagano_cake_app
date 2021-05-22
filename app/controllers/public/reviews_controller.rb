class Public::ReviewsController < ApplicationController

  def create
    @product = Product.find(params[:product_id])
    @review = Review.new
    review = @product.reviews.new(review_params)
    review.customer_id = current_customer.id
    review.save
  end

  def index
    @product = Product.find(params[:product_id])
    @review = Review.new
  end

  def destroy
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])
    @review.destroy
    render :create
  end

  private

  def review_params
    params.require(:review).permit(:review)
  end

end
