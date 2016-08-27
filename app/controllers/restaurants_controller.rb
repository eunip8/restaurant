class RestaurantsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @restaurants = Restaurant.all.order(name: :asc)
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @review = Review.new
    @reviews = @restaurant.reviews.order(created_at: :desc)
  end

  def new
    @restaurant = Restaurant.new
  end

  def edit #displays edit page
    @restaurant = Restaurant.find(params[:id])
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)

    if @restaurant.save
      redirect_to @restaurant, notice: 'Successfully posted restaurant'
    else
      render action: 'new'
    end
  end

  def update  #note update vs. edit above
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update(restaurant_params)
      redirect_to @restaurant
    else
      render 'edit'
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy

    redirect_to restaurants_path
  end

private

  def restaurant_params
    params.require(:restaurant).permit(:name, :location, :description)
  end
end

  # def authorize_user
  #   if !user_signed_in? || !current_user.admin?
  #     raise ActionController::RoutingError.new("Not Found")
  #   end
  # end
