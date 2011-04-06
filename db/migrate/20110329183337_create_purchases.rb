class CreatePurchases < ActiveRecord::Migration
  def self.up
    create_table "purchases", :force => true do |t|
      t.string    "number",      :limit => 15
      t.decimal   "item_total", :precision => 8, :scale => 2, :default => 0.0, :null => false
      t.decimal   "total",      :precision => 8, :scale => 2, :default => 0.0, :null => false
      t.datetime  "created_at"
      t.datetime  "updated_at"
      t.string    "state"
    end

    add_index "purchases", ["number"], :name=> "index_purchases_on_number"
  end

  def self.down
  end
end
