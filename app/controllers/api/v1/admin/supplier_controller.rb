class Api::V1::Admin::SupplierController < Api::V1::Admin::AdminController
  before_action :authenticate_model_token

  # post
  def index
    begin
      @suppliers = Supplier.all
      render :json => { message: "取得廠商列表成功", suppliers: @suppliers, status: 200 }
    rescue Exception => e
      logger.error "----- 取得供應商列表發生錯誤！！！ -> #{e}"
      render :json => { message: "發生不明錯誤", status: 500 }, :status => :bad_request
    end
  end
end