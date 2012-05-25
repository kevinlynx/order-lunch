class Food < ActiveRecord::Base
  def order_count
    Order.where("food_id=#{self.id}").count
  end
end
