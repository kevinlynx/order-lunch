class FoodsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @foods = Food.all
  end

  def create
    @food = Food.new(params[:food])
    respond_to do |format|
      if @food.save
        format.html { redirect_to root_path, :notice => t('tip.create_success') }
      else
        format.html { redirect_to root_path, :notice => t('tip.create_failed') }
      end
    end
  end

  def edit
    @food = Food.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @food = Food.find(params[:id])
    Order.destroy_by_food(@food.id)
    @food.destroy
    respond_to do |format|
      format.html { redirect_to root_path, :notice => t('tip.destroy_success') }
    end
  end

  def update
    @food = Food.find(params[:id])
    respond_to do |format|
      if @food.update_attributes(params[:food])
        format.html { redirect_to root_path, :notice => t('tip.update_success') }
      else
        format.html { redirect_to root_path, :notice => t('tip.update_failed') }
      end
    end
  end

  def destroy_many
    food_ids = params[:food_ids].collect { |id| id.to_i } if params[:food_ids]
    food_ids.each do |id|
        food = Food.find(id)
        Order.destroy_by_food(id)
        food.destroy
    end if food_ids
    ret = food_ids ? true : false
    respond_to do |format|
      if ret 
        format.html { redirect_to root_path, :notice => t('tip.destroy_success') }
      else
        format.html { redirect_to root_path, :notice => t('tip.destroy_failed') }
      end
    end
  end
end

