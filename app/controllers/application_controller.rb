class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :bad_request_response
  rescue_from ActionDispatch::Http::Parameters::ParseError, with: :parse_error

  private

  def not_found_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404))
      .serialize_json, status: :not_found
  end

  def bad_request_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 400))
      .serialize_json, status: :bad_request
  end
  
  def parse_error(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 400))
      .serialize_json, status: :bad_request
  end
end
