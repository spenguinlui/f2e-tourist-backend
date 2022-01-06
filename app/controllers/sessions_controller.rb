# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :authenticate_user_token, only: [:destroy]

  def create
    if valid_user?
      render json: { message: "OK", auth_token: @user.auth_token, favorites: @user.favorites }, status: 200
    else
      render json: { message: "無效的電子信箱或密碼" }, status: 401
    end
  end

  def destroy
    begin
      @user.regenerate_auth_token
      render json: { message: "OK" }, status: 200
    rescue Exception => e
      render json: { message: e }, status: 400
    end
  end

  private

  def sign_in_params
    params.permit(:email, :password)
  end

  def valid_user?
    @user = User.find_by(email: params[:email])
    return false if @user.blank?

    @user.valid_password?(params[:password])
  end
end
