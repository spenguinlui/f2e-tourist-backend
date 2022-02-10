# frozen_string_literal: true

class Api::V1::User::RegistrationsController < Api::V1::User::UserController
  before_action :authenticate_model_token, except: [:sign_up]

  # post
  def sign_up
    begin
      if not User.exists?(email: user_params[:email])
        @user = User.create!(user_params)
        render :json => { message: "成功加入會員", auth_token: @user.auth_token, status: 200 }
      else
        render :json => { message: "#{user_params[:email]} 會員已存在", status: 400 }, :status => :bad_request
      end
    rescue Exception => e
      logger.error "----- 使用者註冊發生錯誤！！！ -> #{e}"
      render :json => { message: "發生不明錯誤", status: 500 }, :status => :bad_request
    end
  end

  private

  def user_params
    params.permit(:email, :password, :name)
  end

end
