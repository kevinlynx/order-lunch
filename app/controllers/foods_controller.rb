class FoodsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @foods = Food.all
  end

  def create
    @food = Food.create(params[:food])
    respond_to do |format|
      format.html { redirect_to root_path, :notice => 'create success' }
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
    @food.destroy
    respond_to do |format|
      format.html { redirect_to root_path, :notice => 'destroy success' }
    end
  end

  def update
    @food = Food.find(params[:id])
    @food.update_attributes(params[:food])
    respond_to do |format|
      format.html { redirect_to root_path, :notice => 'update success' }
    end
  end

  def destroy_many
    food_ids = params[:food_ids].collect { |id| id.to_i } if params[:food_ids]
    food_ids.each do |id|
        food = Food.find(id)
        food.destroy
    end if food_ids
    ret = food_ids ? true : false
    respond_to do |format|
      if ret 
        format.html { redirect_to root_path, :notice => 'destroy success' }
      else
        format.html { redirect_to root_path, :notice => 'destroy failed' }
      end
    end
  end
end

