class Api::V0::VendorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  def index
    vendors = Market.find(params[:id]).vendors
    render json: VendorSerializer.new(vendors)
  end

  def create
    vendor = Vendor.new(vendor_params)

    if vendor.save
      render json: VendorSerializer.new(vendor), status: :created
    else
      render json: ErrorSerializer.new(ErrorMessage.new(vendor.errors.full_messages, 400))
      .serialize_json, status: :bad_request
    end

  end

  private

  def vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end

  def not_found_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404))
      .serialize_json, status: :not_found
  end
end
