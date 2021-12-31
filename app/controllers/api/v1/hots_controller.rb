class Api::V1::HotsController < ApplicationController

  def index
    begin
      top = params[:top] || 30
      skip = params[:skip] || 0

      search_weight = 0.1
      enter_weight = 1
      favorite_weight = 1.5

      local_item = LocalItem.order("(search_count * #{search_weight}) + (enter_count * #{enter_weight}) + (favorite_count * #{favorite_weight}) DESC").offset(skip).limit(top)

      @ids = []
      local_item.map { |item| @ids << item.ptx_data_id }

      render json: @ids.to_json, status: 200
    rescue Exception => e
      render json: { error: e }, status: 400
    end
  end
end
