class Api::V1::HotsController < ApplicationController

  # get
  def index
    begin
      top = params[:top] || 30
      skip = params[:skip] || 0

      @ids = get_hots_by_redis

      if @ids.nil?
        @ids = []
        local_item = LocalItem.order_by_hot({ skip: skip, top: top })
        local_item.map { |item| @ids << item.ptx_data_id }
        set_hots_by_redis(@ids)
      end

      render :json => { message: "成功取得熱門列表", ids: @ids, status: 200 }
    rescue Exception => e
      logger.error "----- 取得熱門列表發生錯誤！！！ -> #{e}"
      render :json => { message: "發生不明錯誤", status: 500 }, :status => :bad_request
    end
  end

  private

  def get_hots_by_redis
    @redis = Redis.new
    redis_hots = @redis.get("hot_array")
    if redis_hots.present?
      JSON.parse(redis_hots)
    else
      nil
    end
  end

  def set_hots_by_redis(ids)
    @redis.set("hot_array", ids)
    @redis.expire("hot_array", (10 * 60)) # live in 10 minute
  end
end
