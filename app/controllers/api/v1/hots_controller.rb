class Api::V1::HotsController < ApplicationController

  # get
  def index
    begin
      top = params[:top] || 30
      skip = params[:skip] || 0

      local_item = LocalItem.order_by_hot({ skip: skip, top: top })
      @ids = []
      local_item.map { |item| @ids << item.ptx_data_id }

      render :json => { message: "成功取得熱門列表", ids: @ids, status: 200 }
    rescue Exception => e
      logger.error "----- 取得熱門列表發生錯誤！！！ -> #{e}"
      render :json => { message: "發生不明錯誤", status: 500 }, :status => :bad_request
    end
  end
end
