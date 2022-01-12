# frozen_string_literal: true

class Api::V1::Admin::SessionsController < Api::V1::Admin::AdminController
  before_action :authenticate_admin_token, only: [:sign_out]

  def check
    @admin = Admin.find_by(auth_token: params[:auth_token])
    if @admin.present?
      render json: { success: "OK" }, status: 200
    else
      render json: { error: "查無此帳號" }, status: 200
    end
  end

  def sign_in
    if valid_admin?
      render json: { auth_token: @admin.auth_token }, status: 200
    else
      render json: { message: "無效的電子信箱或密碼" }, status: 401
    end
  end

  def sign_out
    begin
      @admin.regenerate_auth_token
      render json: { message: "OK" }, status: 200
    rescue Exception => e
      render json: { message: e }, status: 400
    end
  end

  private

  def sign_in_params
    params.permit(:email, :password)
  end

  def valid_admin?
    puts "email"
    puts params[:email]
    @admin = Admin.find_by(email: params[:email])
    return false if @admin.blank?

    puts "password"
    puts params[:password]
    @admin.valid_password?(params[:password])
  end
end
