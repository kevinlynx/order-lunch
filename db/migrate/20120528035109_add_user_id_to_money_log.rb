class AddUserIdToMoneyLog < ActiveRecord::Migration
  def change
    add_column :money_logs, :user_id, :integer
  end
end
