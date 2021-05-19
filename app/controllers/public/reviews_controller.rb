class Public::ReviewsController < ApplicationController
  
  def create
    product = Product.find(params[:product_id])
    review = current_customer.reviews.new(review_params)
    review.product_id = product.id
    review.save
    redirect_to product_reviews_path(params[:product_id])
  end

  def index
    @product = Product.find(params[:product_id])
    @review = Review.new
  end

  def destroy
    Review.find_by(id: params[:id], product_id: params[:product_id]).destroy
    redirect_to product_reviews_path(params[:product_id])
  end
  
  private

  def review_params
    params.require(:review).permit(:review)
  end
  
end
