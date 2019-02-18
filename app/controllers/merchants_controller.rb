class MerchantsController < ApplicationController
  before_action :require_merchant, only: [:show]

  def index
    @merchants = User.active_merchants
    @top_three_merchants_by_revenue = @merchants.top_merchants_by_revenue(3)
    @top_three_merchants_by_fulfillment = @merchants.top_merchants_by_fulfillment_time(3)
    @bottom_three_merchants_by_fulfillment = @merchants.bottom_merchants_by_fulfillment_time(3)
    @top_states_by_order_count = User.top_user_states_by_order_count(3)
    @top_cities_by_order_count = User.top_user_cities_by_order_count(3)
    @top_orders_by_items_shipped = Order.top_orders_by_items_shipped(3)
  end

  def show
    @merchant = current_user
  end
end
