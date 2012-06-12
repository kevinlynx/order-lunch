class AddVisitedAtToSys < ActiveRecord::Migration
  def change
    add_column :sys, :visited_at, :datetime
  end
end
