class CreateSys < ActiveRecord::Migration
  def change
    create_table :sys do |t|
      t.integer :run
      t.integer :stop_hour
      t.integer :stop_min

      t.timestamps
    end
  end
end
