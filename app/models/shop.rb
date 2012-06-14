class Shop < ActiveRecord::Base
  validates :name, :presence => true
  validates :name, :uniqueness => true

  def foods
    Food.where("shop_id=#{self.id}")
  end

  def sort_foods
    foods.sort_by { |food| food.order_count }.reverse
  end

  def order_info
    count = price = 0
    foods.each do |food|
      c = food.order_count
      count += c
      price += c * food.price
    end
    return count, price
  end

  def destroy_foods
    foods.each do |food|
      food.destroy
    end
  end

  def check_hide
    self.hide = !self.hide?
    self.save
  end
end
