class AddShopIdToFood < ActiveRecord::Migration
  def change
    add_column :foods, :shop_id, :integer
  end
end
