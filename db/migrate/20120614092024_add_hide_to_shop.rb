class AddHideToShop < ActiveRecord::Migration
  def change
    add_column :shops, :hide, :boolean, :default => false
  end
end
