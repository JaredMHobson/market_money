class Api::V0::VendorsController < ApplicationController

  def create
    render json: VendorSerializer.new(Vendor.create!(vendor_params)),
    status: :created
  end

  def destroy
    render json: Vendor.find(params[:id]).destroy,
    status: :no_content
  end

  def show
    render json: VendorSerializer.new(Vendor.find(params[:id]))
  end

  def update
    vendor = Vendor.find(params[:id])
    # bang is used to raise an exception if the update fails
    vendor.update!(vendor_params)
    render json: VendorSerializer.new(vendor)
  end

  private

  def vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end
end
