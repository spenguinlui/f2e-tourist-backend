class Api::V1::HotsController < ApplicationController

  # get
  def index
    begin
      top = params[:top] || 30
      skip = params[:skip] || 0

      local_item = LocalItem.order_by_hot({ skip: skip, top: top })
      @ids = []
      local_item.map { |item| @ids << item.ptx_data_id }

      render json: @ids.to_json, status: 200
    rescue Exception => e
      render json: { error: e }, status: 400
    end
  end
end
