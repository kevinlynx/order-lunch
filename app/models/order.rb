class Order < ActiveRecord::Base
  belongs_to :user

  def build_relation(user)
    self.user = user
    user.orders << self
  end

  def food_name
    food = Food.find(self.food_id)
    food.name
  end

  def full_food_name
    food = Food.find(self.food_id)
    food.full_name
  end

  def food_price
    food = Food.find(self.food_id)
    food.price
  end

  def self.total_price
    price = 0
    Order.all.each do |order|
      price += order.food_price
    end
    price
  end

  def self.destroy_by_food(food_id)
    Order.where("food_id=#{food_id}").each do |order|
      order.destroy
    end
  end
end
