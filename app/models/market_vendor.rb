class MarketVendor < ApplicationRecord
  belongs_to :market
  belongs_to :vendor

  validates :market_id, presence: true, numericality: true
  validates :vendor_id, presence: true, numericality: true
end
