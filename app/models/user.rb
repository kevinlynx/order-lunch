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
    self.name == "admin" or self.name == "master"
  end

  def order_cost
    cost = 0
    self.orders.each do |order|
      cost = cost + order.food_price
    end
    cost
  end

  def change_money(val, desc)
    val = (val * 100).to_i
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
          price = (order.food_price * 100).to_i
          cost += price
          user.add_money_log(-price, order.full_food_name, user.money - cost)
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

  def reset_pwd
    pwd = generate_pwd
    self.password = pwd
    self.save!
    pwd
  end

  private
    def generate_pwd
        o = [('a'..'z'), ('A'..'Z'), (0..9)].map { |i| i.to_a }.flatten
        (1..6).map { o[rand(o.length)] }.join
    end
end
