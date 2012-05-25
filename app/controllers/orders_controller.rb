class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def create
    order = Order.create(:food_id => params[:food_id].to_i)
    order.build_relation(current_user)
    respond_to do |format|
      format.html { redirect_to root_path, :notice => 'order success' }
    end
  end

  def create_many
    food_ids = params[:food_ids].collect { |id| id.to_i } if params[:food_ids]
    food_ids.each do |id|
      order = Order.create(:food_id => id)
      order.build_relation(current_user)
    end if food_ids
    respond_to do |format|
      format.html { redirect_to root_path, :notice => 'order success' }
    end
  end

  def destroy
    @order= Order.find(params[:id])
    @order.destroy
    respond_to do |format|
      format.html { redirect_to root_path, :notice => 'cancel success' }
    end
  end
end

