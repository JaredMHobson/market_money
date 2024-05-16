class Api::V0::VendorsController < ApplicationController
  
  def show
    vendor = Vendor.find_by(id: params[:id])
    if vendor
      render json: VendorSerializer.new(vendor)
    else
      render json: { errors: [{ detail: "Can't find Vendor with 'id'=#{params[:id]}" }] }, status: :not_found
    end
  end
end
