class Api::V1::Admin::SettingController < Api::V1::Admin::AdminController
  before_action :authenticate_model_token

  # post
  def index
    begin
      @settings = Setting.all
      render :json => { message: "取得設定檔成功", settings: @settings, status: 200 }
    rescue Exception => e
      logger.error "----- 取得設定檔發生錯誤！！！ -> #{e}"
      render :json => { message: "發生不明錯誤", status: 500 }, :status => :bad_request
    end
  end

  # patch
  def update
    begin
      @setting = Setting.find(params[:id])
      @setting.update!(attribute_name: setting_params[:attribute_name], attribute_value: setting_params[:attribute_value])
      @settings = Setting.all
      render :json => { message: "更新設定檔成功", settings: @settings, status: 200 }
    rescue Exception => e
      logger.error "----- 更新設定檔發生錯誤！！！ -> #{e}"
      render :json => { message: "發生不明錯誤", status: 500 }, :status => :bad_request
    end
  end

  private

  def setting_params
    params.permit(:attribute_name, :attribute_value)
  end
end