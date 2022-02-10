class Api::V1::Admin::UsersController < Api::V1::Admin::AdminController
  before_action :authenticate_model_token

  # post
  def index
    begin
      @users = User.all
      render :json => { message: "取得廠商列表成功", users: @users, status: 200 }
    rescue Exception => e
      logger.error "----- 取得使用者列表發生錯誤！！！ -> #{e}"
        render :json => { message: "發生不明錯誤", status: 500 }, :status => :bad_request
    end
  end

  # post
  def create
  end

  # patch
  def update
  end

  # delete
  def destroy
    begin
      @user = User.find(params[:id])
      @user.destroy
      
      @users = User.all
      render :json => { message: "刪除使用者成功", users: @users, status: 200 }
    rescue Exception => e
      logger.error "----- 刪除使用者發生錯誤！！！ -> #{e}"
      render :json => { message: "發生不明錯誤", status: 500 }, :status => :bad_request
    end
  end
end
