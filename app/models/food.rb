class Food < ActiveRecord::Base
  validates :name, :price, :shop_id, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 1 }

  def order_count
    Order.where("food_id=#{self.id}").count
  end

  def full_name
    Shop.find(self.shop_id).name + self.name
  end

  def order_users
    Order.where("food_id=#{self.id}").collect { |order| order.user }
  end

  def shop
    Shop.find(self.shop_id)
  end
end
