class AddHideToShop < ActiveRecord::Migration
  def change
    add_column :shops, :hide, :boolean
  end
end
