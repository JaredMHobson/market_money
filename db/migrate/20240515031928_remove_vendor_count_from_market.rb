class RemoveVendorCountFromMarket < ActiveRecord::Migration[7.1]
  def change
    remove_column :markets, :vendor_count
  end
end
