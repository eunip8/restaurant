class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new(review_params)
    @review.restaurant = @restaurant #assigning the restaurant to the review

    if @review.save
      redirect_to restaurant_path(@restaurant), notice: 'Review posted successfully'
    else
      flash[:notice] = 'Failed to save review'
      flash[:error] = @review.errors.full_messages(", ")

      redirect_to @restaurant
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to @restaurant
    else
      render 'edit'
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.find(params[:id])
    @review.destroy

    redirect_to @restaurant
  end

private
  def review_params
    params.require(:review).permit(:description, :restaurant_id)
  end
end
