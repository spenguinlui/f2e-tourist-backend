class Api::V1::User::FavoritesController < Api::V1::User::UserController
  before_action :authenticate_user_token

  def index
    render json: { message: "取得 favorites 成功", favorites: @user.favorites }, status: 200
  end

  def update
    begin
      if params[:favorites]
        favorites = JSON.parse(params[:favorites])
        @user.update!(favorites: favorites)
        render json: { message: favorites }, status: 200
      else
        render json: { message: "失敗" }, status: 200
      end
    rescue Exception => e
      render json: { message: e }, status: 200
    end
  end
end