class Api::V0::VendorsController < ApplicationController
  def index
    vendors = Market.find(params[:id]).vendors
    render json: VendorSerializer.new(vendors)
  end

  def create
    render json: VendorSerializer.new(Vendor.create!(vendor_params)),
    status: :created
  end

  private

  def vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end
end
