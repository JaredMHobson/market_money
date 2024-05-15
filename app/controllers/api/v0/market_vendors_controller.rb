class Api::V0::MarketVendorsController < ApplicationController
  def index
    vendors = Market.find(params[:id]).vendors
    render json: VendorSerializer.new(vendors)
  end
end
