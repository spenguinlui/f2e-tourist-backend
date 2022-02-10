class Api::V1::User::FavoritesController < Api::V1::User::UserController
  before_action :authenticate_model_token

  # post
  def index
    render :json => { message: "取得我的旅程成功", favorites: @user.favorites, status: 200 }
  end

  # patch
  def update
    begin
      if params[:favorites]
        @favorites = JSON.parse(params[:favorites])
        @user.update!(favorites: @favorites)

        render :json => { message: "更新我的最愛成功", favorites: @favorites, status: 200 }
      else
        render :json => { message: "無接收到我的最愛項目", status: 200 }
      end
    rescue Exception => e
      logger.error "----- 更新我的最愛發生錯誤！！！ -> #{e}"
      render :json => { message: "發生不明錯誤", status: 500 }, :status => :bad_request
    end
  end
end