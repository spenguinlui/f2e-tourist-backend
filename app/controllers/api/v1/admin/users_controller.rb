class Api::V1::Admin::UsersController < Api::V1::Admin::AdminController
  before_action :authenticate_admin_token

  # post
  def index
    @users = User.all
    render json: @users, status: 200
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
      render json: @users, status: 200
    rescue Exception => e
      render json: { error: e }, status: 400
    end
  end
end
