class Api::V1::Admin::ThemesController < Api::V1::Admin::AdminController
  before_action :authenticate_model_token

  # post
  def index
    begin
      @themes = Theme.all
      render :json => { message: "取得主題列表成功", themes: @themes, status: 200 }
    rescue Exception => e
      logger.error "----- 取得主題列表發生錯誤！！！ -> #{e}"
      render :json => { message: "發生不明錯誤", status: 500 }, :status => :bad_request
    end
  end

  # post
  def show
    begin
      @theme = Theme.find(params[:id])
      render :json => { message: "取得單一主題成功", theme: @theme, status: 200 }
    rescue Exception => e
      logger.error "----- 取得單一主題發生錯誤！！！ -> #{e}"
      render :json => { message: "發生不明錯誤", status: 500 }, :status => :bad_request
    end
  end

  # post
  def create
    begin
      theme_tags = params[:theme_tags].gsub(/\s+/, "").split(',')
      Theme.create!(theme_name: params[:theme_name], theme_tags: theme_tags)
      
      @themes = Theme.all
      render :json => { message: "新增主題成功", themes: @themes, status: 200 }
    rescue Exception => e
      logger.error "----- 新增主題發生錯誤！！！ -> #{e}"
      render :json => { message: "發生不明錯誤", status: 500 }, :status => :bad_request
    end
  end

  # patch
  def update
    begin
      theme = Theme.find(params[:id])
      if params[:theme_tags].is_a? Array
        theme_tags = params[:theme_tags]
      else
        theme_tags = params[:theme_tags].gsub(/\s+/, "").split(',')
      end
      theme.update!(theme_name: params[:theme_name], theme_tags: theme_tags)

      @themes = Theme.all
      render :json => { message: "更新主題成功", themes: @themes, status: 200 }
    rescue Exception => e
      logger.error "----- 更新主題發生錯誤！！！ -> #{e}"
      render :json => { message: "發生不明錯誤", status: 500 }, :status => :bad_request
    end
  end

  # delete
  def destroy
    begin
      theme = Theme.find(params[:id])
      theme.destroy

      @themes = Theme.all
      render :json => { message: "刪除主題成功", themes: @themes, status: 200 }
    rescue Exception => e
      logger.error "----- 刪除主題發生錯誤！！！ -> #{e}"
      render :json => { message: "發生不明錯誤", status: 500 }, :status => :bad_request
    end
  end
end
