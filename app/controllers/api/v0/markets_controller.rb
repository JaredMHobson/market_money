class Api::V0::MarketsController < ApplicationController

  def index
    render json: MarketSerializer.new(Market.all)
  end

  def show
    render json: MarketSerializer.new(Market.find(params[:id]))
  end

  def search
    require 'pry'; binding.pry
    if permitted_search_params?  
      render json: MarketSerializer.new(Market.search(search_params))
    else
      render json: ErrorSerializer.new(ErrorMessage.new("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.", 422))
        .serialize_json, status: :unprocessable_entity
    end
  end

  private

  def search_params
    params.permit(:city, :state, :name)
  end

  def permitted_search_params?
    keys = search_params.keys.sort
    invalid_combo = [["city"], ["city", "name"]]
    invalid_combo.exclude?(keys)
  end
end
