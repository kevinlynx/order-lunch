class ShopsController < ApplicationController
  before_filter :permission_check, :except => [:show]

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
    @shop = Shop.find(params[:id])
    @shop.destroy_foods
    @shop.destroy
    respond_to do |format|
      format.html { redirect_to root_path, :notice => t('tip.destroy_success') }
    end
  end

  def show
    @shop = Shop.find(params[:id])
    @view_type = params[:type]
    @view_type = @view_type.to_sym if @view_type
    partial = 'shops/menu'
    partial = 'shops/menu_core' if @view_type == :stat
    render :text => 
        render_to_string(:partial => partial, :locals => { :shop => @shop })
  end

  def hide
    @shop = Shop.find(params[:id])
    tip = t 'tip.op_failed'
    if @shop
      @shop.check_hide
      tip = t 'tip.op_success'
    end
    respond_to do |format|
      format.html { redirect_to root_path, :notice => tip }
    end
  end
end

