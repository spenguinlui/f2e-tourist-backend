class ApplicationController < ActionController::API
  
  def sign_in
    begin
      if valid_resource?
        if @model == User
          render :json => { message: "登入成功", auth_token: @resource.auth_token, favorites: @resource.favorites, status: 200 }
        else
          render :json => { message: "登入成功", auth_token: @resource.auth_token, status: 200 }
        end
      else
        render :json => { message: "無效的電子信箱或密碼", status: 401 }, :status => :bad_request
      end
    rescue Exception => e
      logger.error "----- 使用者登入發生錯誤！！！ -> #{e}"
      render :json => { message: "發生不明錯誤", status: 400 }, :status => :bad_request
    end
  end

  def sign_out
    begin
      @resource.regenerate_auth_token
      render :json => { message: "登出成功", status: 200 }
    rescue Exception => e
      logger.error "----- 使用者登出發生錯誤！！！ -> #{e}"
      render :json => { message: "發生不明錯誤", status: 400 }, :status => :bad_request
    end
  end

  def check
    begin
      @resource = @model.find_by(auth_token: params[:auth_token])
      if @resource.nil?
        render :json => { message: "無效的 auth_token", status: 401 }, :status => :bad_request
      else
        # @resource.regenerate_auth_token
        if @model == User
          render :json => { message: "使用者已登入", auth_token: @resource.auth_token, favorites: @resource.favorites, status: 200 }
        else
          render :json => { message: "登入重置", auth_token: @resource.auth_token, status: 200 }
        end
      end
    rescue Exception => e
      logger.error "----- 確認使用者是否登入發生錯誤！！！ -> #{e}"
      render :json => { message: "發生不明錯誤", status: 500 }, :status => :bad_request
    end
  end

  private

  def valid_resource?
    @resource = @model.find_by(email: params[:email])
    return false if @resource.blank?
    @resource.valid_password?(params[:password])
  end

  def authenticate_model_token
    @resource = @model.find_by(auth_token: params[:auth_token])
    return render(:json => { message: "無效的 auth_token", status: 401 }) if @resource.nil?
  end
end
