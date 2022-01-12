class Api::V1::Admin::AdminController < ApplicationController

  private

  def authenticate_admin_token
    @admin = Admin.find_by(auth_token: params[:auth_token])
    return render(json: { message:'無效的 auth_token' }, status: 401) if @admin.nil?
  end
end