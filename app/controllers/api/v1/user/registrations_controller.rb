# frozen_string_literal: true

class Api::V1::User::RegistrationsController < Api::V1::User::UserController
  before_action :authenticate_user_token, except: [:sign_up]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def sign_up
    begin
      @user = User.create(user_params)
      render json: { message: "成功加入會員", auth_token: @user.auth_token }, status: 200
    rescue Exception => e
      render json: e, status: 400
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  private

  def user_params
    params.permit(:email, :password, :name)
  end

end
