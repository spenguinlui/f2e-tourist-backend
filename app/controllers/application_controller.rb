class ApplicationController < ActionController::API
  
  def sign_in
    if valid_resource?
      if @model == User
        render json: { message: "OK", auth_token: @resource.auth_token, favorites: @resource.favorites }, status: 200
      else
        render json: { message: "OK", auth_token: @resource.auth_token }, status: 200
      end
    else
      render json: { message: "無效的電子信箱或密碼" }, status: 401
    end
  end

  def sign_out
    begin
      @resource.regenerate_auth_token
      render json: { message: "OK" }, status: 200
    rescue Exception => e
      render json: { message: e }, status: 400
    end
  end

  def check
    @resource = @model.find_by(auth_token: params[:auth_token])
    if @resource.nil?
      render json: { message:'無效的 auth_token' }, status: 400
    else
      # @resource.regenerate_auth_token
      if @model == User
        render json: { auth_token: @resource.auth_token, favorites: @resource.favorites }, status: 200
      else
        render json: { auth_token: @resource.auth_token }, status: 200
      end
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
    return render(json: { message:'無效的 auth_token' }, status: 401) if @resource.nil?
  end
end
