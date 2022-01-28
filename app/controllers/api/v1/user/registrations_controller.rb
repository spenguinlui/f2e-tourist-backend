# frozen_string_literal: true

class Api::V1::User::RegistrationsController < Api::V1::User::UserController
  before_action :authenticate_model_token, except: [:sign_up]

  # post
  def sign_up
    begin
      @user = User.create(user_params)
      render json: { message: "成功加入會員", auth_token: @user.auth_token }, status: 200
    rescue Exception => e
      render json: e, status: 400
    end
  end

  private

  def user_params
    params.permit(:email, :password, :name)
  end

end
