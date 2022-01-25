class Api::V1::Admin::SupplierController < Api::V1::Admin::AdminController
  before_action :authenticate_admin_token

  # post
  def index
    @suppliers = Supplier.all
    render json: @suppliers, status: 200
  end
end