class Food < ActiveRecord::Base
  validates :name, :price, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 1 }

  def order_count
    Order.where("food_id=#{self.id}").count
  end
end
