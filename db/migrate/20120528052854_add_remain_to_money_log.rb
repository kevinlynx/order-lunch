class AddRemainToMoneyLog < ActiveRecord::Migration
  def change
    add_column :money_logs, :remain, :integer
  end
end
