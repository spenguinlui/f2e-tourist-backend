class Api::V1::User::UserController < ApplicationController
  before_action :authenticate_user_token

  private

  def authenticate_user_token
    @user = User.find_by(auth_token: params[:auth_token])
    return render(json: { message:'無效的 auth_token' }, status: 401) if @user.nil?
  end
end