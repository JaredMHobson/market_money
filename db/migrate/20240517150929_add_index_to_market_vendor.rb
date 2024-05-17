class AddIndexToMarketVendor < ActiveRecord::Migration[7.1]
  def change
    add_index :market_vendors, [:market_id, :vendor_id], unique: true
  end
end