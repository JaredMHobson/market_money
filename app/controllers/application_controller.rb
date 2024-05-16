class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :bad_request_response
  rescue_from PG::UniqueViolation, with: :record_not_unique_response

  private

  def not_found_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404))
      .serialize_json, status: :not_found
  end

  def bad_request_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 400))
      .serialize_json, status: :bad_request
  end

  def record_not_unique_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new('Duplicate MarketVendor record', 422))
      .serialize_json, status: :unprocessable_entity
  end
end
