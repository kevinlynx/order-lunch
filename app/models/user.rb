class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation, :remember_me
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  validates :name, :presence => true, :uniqueness => true
  has_many :orders
  has_many :money_logs

  def admin?
    self.name == "admin"
  end

  def order_cost
    cost = 0
    self.orders.each do |order|
      cost = cost + order.food_price
    end
    cost
  end

  def change_money(val, desc)
    self.money += val
    self.save!
    add_money_log(val, desc, self.money)
  end

  def self.commit_orders
    users = User.all
    users.each do |user|
      if not user.admin? and user.orders
        cost = 0
        user.orders.each do |order|
          price = order.food_price
          cost += price
          user.add_money_log(-order.food_price, order.food_name, user.money - cost)
        end
        user.money -= cost
        user.save!
      end
    end
  end

  def self.clear_orders
    Order.destroy_all
  end

  def add_money_log(val, desc, remain)
    log = MoneyLog.create(:value => val, :desc => desc, :remain => remain)
    log.user = self
    self.money_logs << log
  end
end
