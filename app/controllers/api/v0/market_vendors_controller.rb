class Api::V0::MarketVendorsController < ApplicationController
  def index
    vendors = Market.find(params[:id]).vendors
    render json: VendorSerializer.new(vendors)
  end

  def create
    if params[:market_vendor][:market_id].nil? || params[:market_vendor][:vendor_id].nil?
      render json: { errors: [{status: '400', title:'A market_id and vendor_id are required' }]},
      status: :bad_request
    else
      Market.find(market_vendor_params[:market_id])
      Vendor.find(market_vendor_params[:vendor_id])

      render json: MarketVendorSerializer.new(MarketVendor.create!(market_vendor_params)),
      status: :created
    end
  end

  def destroy
    market = Market.find(market_vendor_params[:market_id])
    vendor = Vendor.find(market_vendor_params[:vendor_id])

    market_vendor = MarketVendor.find_by(
      market: market,
      vendor: vendor
      )

      market_vendor.delete

      render json: '', status: :no_content
  end

  private

  def market_vendor_params
    params.require(:market_vendor).permit(:market_id, :vendor_id)
  end
end
