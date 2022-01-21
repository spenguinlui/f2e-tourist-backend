# frozen_string_literal: true

class Api::V1::Supplier::SessionsController < Api::V1::Supplier::SupplierController
  before_action :authenticate_supplier_token, only: [:sign_out]

  def check
    @supplier = Supplier.find_by(auth_token: params[:auth_token])
    if @supplier.present?
      render json: { success: "OK" }, status: 200
    else
      render json: { error: "查無此帳號" }, status: 200
    end
  end

  def sign_in
    if valid_supplier?
      render json: { auth_token: @supplier.auth_token }, status: 200
    else
      render json: { message: "無效的電子信箱或密碼" }, status: 401
    end
  end

  def sign_out
    begin
      @supplier.regenerate_auth_token
      render json: { message: "OK" }, status: 200
    rescue Exception => e
      render json: { message: e }, status: 400
    end
  end

  private

  def sign_in_params
    params.permit(:email, :password)
  end

  def valid_supplier?
    @supplier = Supplier.find_by(email: params[:email])
    return false if @supplier.blank?

    @supplier.valid_password?(params[:password])
  end
end
