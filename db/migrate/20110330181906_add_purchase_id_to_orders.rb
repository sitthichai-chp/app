class AddPurchaseIdToOrders < ActiveRecord::Migration
  def self.up
    add_column "orders", "purchase_id", :integer
    add_index "orders", "purchase_id"
  end

  def self.down
    remove_column "orders", "purchase_id"
  end
end
