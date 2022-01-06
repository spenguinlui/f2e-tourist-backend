# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    build_resource(user_params)
    begin
      resource.save!
      sign_up(resource_name, resource) if resource.persisted?
      render json: { message: "成功加入會員", auth_token: resource.auth_token }, status: 200
    rescue Exception => e
      render json: e, status: 200 # 開發時先設定 200
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
