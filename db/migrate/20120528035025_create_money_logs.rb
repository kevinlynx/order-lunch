class CreateMoneyLogs < ActiveRecord::Migration
  def change
    create_table :money_logs do |t|
      t.integer :value
      t.string :desc

      t.timestamps
    end
  end
end
