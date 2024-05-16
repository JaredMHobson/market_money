class Api::V0::VendorsController < ApplicationController
  
  def show
    vendor = render json: VendorSerializer.new(Vendor.find(params[:id]))
    if vendor
      render json: VendorSerializer.new(vendor)
    else
      render json: { errors: [{ detail: "Can't find Vendor with 'id'=#{params[:id]}" }] }, status: :not_found
    end
  end
end
