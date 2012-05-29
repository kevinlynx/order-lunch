class Shop < ActiveRecord::Base
  validates :name, :presence => true
  validates :name, :uniqueness => true

  def foods
    Food.where("shop_id=#{self.id}")
  end

  def sort_foods
      foods.sort_by { |food| food.order_count }.reverse
  end
end
