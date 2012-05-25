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
end
