class Api::V1::Supplier::SupplierController < ApplicationController
  before_action :authenticate_supplier_token

  private

  def authenticate_supplier_token
    @supplier = Supplier.find_by(auth_token: params[:auth_token])
    return render(json: { message:'無效的 auth_token' }, status: 401) if @supplier.nil?
  end
end