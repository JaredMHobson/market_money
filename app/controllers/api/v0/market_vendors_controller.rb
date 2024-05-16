class Api::V0::MarketVendorsController < ApplicationController
  def index
    vendors = Market.find(params[:id]).vendors
    render json: VendorSerializer.new(vendors)
  end

  def destroy
    market = Market.find(market_vendor_params[:market_id])
    vendor = Vendor.find(market_vendor_params[:vendor_id])

    market_vendor = MarketVendor.find_by(
      market: market,
      vendor: vendor
      )

      market_vendor.delete
  end

  private

  def market_vendor_params
    params.require(:market_vendor).permit(:market_id, :vendor_id)
  end
end
