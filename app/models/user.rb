class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation, :remember_me
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  validates :name, :presence => true, :uniqueness => true
  has_many :orders

  def admin?
    self.name == "admin"
  end

  def order_cost
    cost = 0
    self.orders.each do |order|
      food = Food.find order.food_id
      cost = cost + food.price
    end
    cost
  end
end
