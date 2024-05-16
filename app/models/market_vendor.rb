class MarketVendor < ApplicationRecord
  belongs_to :market
  belongs_to :vendor

  validates :market_id, presence: true, numericality: true
  validates :vendor_id, presence: true, numericality: true
  # validates :market_id, uniqueness: { scope: :vendor_id, message: 'This MarketVendor already exists'}
end
