class Api::V1::ThemesController < ApplicationController

  # get
  def index
    begin
      @themes = Theme.all
      render :json => { message: "取得主題列表成功", themes: @themes, status: 200 }
    rescue Exception => e
      logger.error "----- 取得主題列表發生錯誤！！！ -> #{e}"
      render :json => { message: "發生不明錯誤", status: 500 }, :status => :bad_request
    end
  end

  # get
  def show
    begin
      @theme = Theme.find(params[:id])
      render :json => { message: "取得單一主題成功", theme: @theme, status: 200 }
    rescue Exception => e
      logger.error "----- 取得單一主題發生錯誤！！！ -> #{e}"
      render :json => { message: "發生不明錯誤", status: 500 }, :status => :bad_request
    end
  end
end
