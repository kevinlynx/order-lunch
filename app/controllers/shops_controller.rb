class ShopsController < ApplicationController
  def new
    respond_to do |format|
      format.js
    end
  end

  def create
    @shop = Shop.new(params[:shop])
    respond_to do |format|
      if @shop.save
        format.html { redirect_to root_path, :notice => t('tip.create_success') }
      else
        format.html { redirect_to root_path, :notice => t('tip.create_failed') }
      end
    end
  end

  def destroy
    @shop = Food.find(params[:id])
    @shop.destroy
    respond_to do |format|
      format.html { redirect_to root_path, :notice => t('tip.destroy_success') }
    end
  end
end

